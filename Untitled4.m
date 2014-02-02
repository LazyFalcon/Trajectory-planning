function Untitled4()
                        bez = [
                            0 1 0 1; 
                            1 1 0 4.8; 
                            0 2 0 0.2;
                            1 2 0 1
                            ];
                    bez2 = [
                            1 2 0 1; 
                            0 2 0 0.8; 
                            1 1 0 5.2;
                            0 1.5 0 1
                            ];
                        t = 0:0.01:1;
                        points = bezier4(bez, t, 3);
                        points2 = bezier4(bez2, t, 3);
                        y = [points(:,2); points2(2:end,2)];
            
            gp = y;
        sampling = 1; %mm
        efector_vel = 40; % mm/s
        move_time = sampling/efector_vel; % s
%% robot
% wartoœæ wyjœciowych wspó³¿ednych z³aczowych
robot.bindGP = [0 0 -30 40 0 0 -10 0]*pi/180;
robot.min = [0 -170 -190 0 -29  -190 -120 -360 ]*pi/180;
robot.max = [0 170 45 256 0  190 120 360]*pi/180;
robot.max_v = [1 1 1 1 1 1 1 1]*0.1;
robot.max_a = [1 1 1 1 1 1 1 1]*0.05;
robot.efector_radius = 4;
robot.parts = 1;
%%
for i=1:1:2
         len = length(gp);
        dt = ones(len-1,1)*move_time; % czasy pomiêdzy kazdym punktem

        % wyznaczanie prêdkoœci
        velocities = doVelocities(robot, gp, dt,move_time);
        % obcinanie prêdkoœci
        dt =  cutVelocities(robot, velocities, dt, move_time);
%% interpolacja
        gp = interpolateGP(dt, gp, move_time);
        len = length(gp);
        dt = ones(len-1,1)*move_time; % czasy pomiêdzy kazdym punktem
        velocities = doVelocities(robot, gp, dt,move_time);

%%
        accelerations = doAccelerations(robot, velocities, dt, move_time);
        dt = cutAccelerations(robot, accelerations, dt);
        gp = interpolateGP(dt, gp, move_time);

        
        % compute new dt
        len = length(gp(:,1));
        dt = ones(len-1,1)*move_time; % czasy pomiêdzy kazdym punktem
        vel  = doVelocities(robot, gp, dt,move_time);
end
%%
        times = zeros(length(dt)+1,1);
        for i = 1:1:length(dt)
            times(i+1) = times(i) + dt(i);
        end
%%
%        figure(2)
       subplot(3,1,1)
           hold on
            plot( gp,'k');
            title('Wspó³rzêdne')
            xlabel('[s]')
            ylabel('[rad]')
            
%         figure(30)
       subplot(3,1,2)
           hold on
            plot(vel,'k');
            title('Prêdkoœci')    
            xlabel('[-]')
            ylabel('[rad/s]')
            
%         figure(40)
       subplot(3,1,3)
           hold on
            acc =  doAccelerations(robot, vel, dt,move_time);
            plot(acc, 'k')
            title('Przyspieszenia')
            xlabel('[-]')
            ylabel('[rad/{s}^{2}]')
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
        max_v = robot.max_v(1);
        for i = 1:1:length(dt)
            if abs(velocities(i)) > max_v
                t = move_time;
                dt(i) = max(abs(velocities(i)) * t /max_v, dt(i));
            end
        end
    out = dt;
end

function out = cutAccelerations(robot, acc, dt)
    st = 1;
    en = 1;
    lastid = length(acc);
    bool = false;

        max_a = robot.max_a(1);
        for i = 1:1:length(acc)
                if abs(acc(i)) > max_a && bool == false
                    st = i;
                    bool = true;
                end

                if (abs(acc(i)) < max_a || i == lastid) && bool == true
                    bool = false;
                    first = false;
                    last = false;
                    en = i;
                    
                    %% rozszerzamy zakres
                    delay = 40;
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
                            1 1 0 0.6; 
                            0 2 0 0.2;
                            1 2 0 1
                            ];
                    
                    if ~first && ~last
                        t = 0:1/len:1;
                        points = bezier4(bez, t, 3);
                        delays = [points(:,2); points(end-1:-1:1,2)];
%                         figure(5)
%                         hold on
%                         plot(delays)
%                         drawPath3d(points, 'k');
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
                end

            end
            bool = false;
    out = dt;
end