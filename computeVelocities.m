function out = computeVelocities(robot, gps, efector_vel, draw)
% wyznacza prêdkoœci z³¹czowe, zwraca
% punkty trasy
% gp dla nich
% prêdkoœci z³¹czowe

% zak³adamy ¿e dostajemy gp dla punktów lez¹czych co [sampling = 1mm], tu
% te punkty próbkujemy z czêstotliwoœci¹ 100hz

if nargin == 3
    draw = false;
end

    sampling = 1; %mm
%     move_time = sampling/efector_vel; % s
    move_time = 0.01;% sekundy
    gp = [gps(1,:); gps(1,:); gps(1,:); gps ; gps(end,:); gps(end,:); gps(end,:)];
    len = length(gp(:,1));
    dt = ones(len-1,1)*sampling/efector_vel; % czasy pomiêdzy kazdym punktem
           
        % próbkujemy z czêstotliowœci¹ 100hz
    gp = interpolateGP(dt, gp, move_time);   
    
    for i =1:1:10
        len = length(gp(:,1));
        dt = ones(len-1,1)*move_time; % czasy pomiêdzy kazdym punktem

        % wyznaczanie prêdkoœci
        velocities = doVelocities(robot, gp, dt,move_time);
        % obcinanie prêdkoœci
        dt =  cutVelocities(robot, velocities, dt, move_time);
				%% interpolacja
        gp = interpolateGP(dt, gp, move_time);
        len = length(gp(:,1));
        dt = ones(len-1,1)*move_time; % czasy pomiêdzy kazdym punktem
        velocities = doVelocities(robot, gp, dt,move_time);
%%
        accelerations = doAccelerations(robot, velocities, dt, move_time);

        gp = cutAccelerations(robot, gp, accelerations, dt,move_time);
        
            % obcinanie niepotrzebnych zer na koñcu
            to_cut = 0;
            zer = zeros(size(gp(1,:)));
            for i = length(dt):-1:1
                if sqrt(sum(velocities(i,:).^2)) < 0.0001
                    to_cut = to_cut+1;
                end
            end
            gp = gp(1:end - to_cut,:);
       
        
    end
     % compute new dt
        len = length(gp(:,1));
        dt = ones(len-1,1)*move_time;
        vel  = doVelocities(robot, gp, dt,move_time);
        
        
        times = zeros(length(dt)+1,1);
        q = gp(1,:);

        for i = 1:1:length(dt)-1
            times(i+1) = times(i) + dt(i);
            q = [q; q(end,:) + vel(i+1,:)*move_time];
        end
         times(end) = times(end-1) + dt(end);
         
        path = simulateRobotFi(robot, gps);
        pts = simulateRobotFi(robot, q);
        out{1} = pts;
        out{2} = gp;
        out{3} = times;
        out{4} = vel;

    if draw
            hFig = figure(2);
%            hold on
            plot(times, gp,'','LineWidth',1.5);
%             title('Wspó³rzêdne')
            xlabel('[s]')
            ylabel('[rad]')
            legend('1','2','3','4','5','6')
            set(hFig, 'Position', [100 100 500 300])
            
            hFig = figure(30);
%            hold on
            plot(vel,'LineWidth',1.5);
%             title('Prêdkoœci')    
            xlabel('[-]')
            ylabel('[rad/s]')
            legend('1','2','3','4','5','6')
            set(hFig, 'Position', [100 100 500 300])
            
        figure(40)
            acc =  doAccelerations(robot, vel, dt,move_time);
            plot(acc)
            title('Przyspieszenia')
            xlabel('[-]')
            ylabel('[rad/{s}^{2}]')
%             
        figure(1)
            hold on
            drawPath3d(pts, 'b-.', 2);
            drawPath3d(path, 'k',1.5);
            title('Porownanie tras')
            xlabel('[mm]')
            ylabel('[mm]')
            zlabel('[mm]')
            legend('wejœciowa', 'wygenerowana')


    end
end

function out = interpolateGP(dt, gps, move_time)
    times = zeros(length(dt)+1,1);
    for i = 1:1:length(dt)
        times(i+1) = times(i) + dt(i);
    end
    t = 0:move_time:times(end)+move_time;
    out = interp1(times, gps, t,'cubic');
end

function out = doVelocities(robot, gps, dt,move_time)
    out = diff(gps) / move_time;
end

function out = doAccelerations(robot, velocities, dt,move_time)
    out = diff(velocities)/move_time;
end

function out = cutVelocities(robot, velocities, dt, move_time)
    for q = 1:1:length(velocities(1,:))
        max_v = robot.max_v(q);
        bool = false;
        for i = 1:1:length(dt)
                t = move_time;
                dt(i) = max(abs(velocities(i, q)) * t /max_v, dt(i));
        end
    end
    out = dt;
end

function out = cutAccelerations(robot, gp, acc, dt,move_time)
    st = 1;
    en = 1;
    lastid = length(acc);
    bool = false;

    for q = 1:1:length(acc(1,:))
        max_a = robot.max_a(q);
%         for i = 1:1:length(acc)
            i = 0;
            while i < length(acc)
                i = i+1;
                
                if abs(acc(i, q)) > max_a&& bool == false
                    st = i;
                    bool = true;
                end

                if (abs(acc(i, q)) < max_a || i == lastid) && bool == true
                    bool = false;
                    first = false;
                    last = false;
                    en = i;
                    
                    %% rozszerzamy zakres
                    delay = 10;
										
                    if st > delay
                        st = st - delay;
                    else
                        st = 1;
                        first = true;
                    end
                    
                    if en < length(dt)-delay
                        en = en + delay;
                    else
                        en = length(dt);
                        last = true;
%                         st = en-10;
                    end
                    
                    %%
                    % wyg³adŸ
                        mid = (en + st)/2;
                        len = ceil((en - st)/2);

                        bez = [
                            0 1 0 1; 
                            1 1 0 4; 
                            0 1.3 0 0.1;
                            1 1.3 0 1
                            ];
                    
                    if ~first && ~last
                        t = 0:1/len:1;
                        points = bezier4(bez, t, 3);
                        delays = [points(:,2); points(end-1:-1:1,2)];
%                         figure(123)
%                         plot(0:1/len/2:1,delays)
                    elseif first
                        t = 0:1/len/2:1;
                        points = bezier4(bez, t, 3);
                        delays = [points(end-1:-1:1,2)];
                    elseif last
                        t = 0:1/len/2:1;
                        points = bezier4(bez, t, 3);
                        delays = [points(:,2);];
                    end
                    
                    it = 1;
                     for j = st:1:en-1
                         dt(j) = dt(j) * delays(it);
                         it = it+1;
                     end
                        gp = interpolateGP(dt, gp, move_time);
                        len = length(gp(:,1));
                        dt = ones(len-1,1)*move_time; % czasy pomiêdzy kazdym punktem
                        velocities = doVelocities(robot, gp, dt,move_time);
                        acc = doAccelerations(robot, velocities, dt, move_time);     
                end

            end
            
            bool = false;
    end
    out = gp;
end
