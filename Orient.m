function out = Orient(robot, current_gp, orientation, error, limit)
% zwraca zbiór wspó³¿êdnych z³¹czowych pozwalajacych zorientowaæ efektor
% robota
    if nargin<4
        limit = 600;
        error = 0.0001;
    elseif nargin<5
      limit = 600;
    end
    
    %% compute aim
    orientation = w_normalize(orientation);
    enhancement = computeEnhancement(robot.zmie);
    out = current_gp;
    initial_points = simulateRobotFi2(robot, current_gp);
    aim = initial_points(end, :) ;
    delta_prev = 0;
%     errors = [];
    
        e = error*2;
        prev_e = e;
        i = 0;        
            while e>error && i < limit
                jacobi = w_jacobian(current_gp,  robot);
                jacobi = jacobi';
                jjp = jacobi'*jacobi;
                i = i + 1;
    
                c_pts = simulateRobotFi2(robot, current_gp);
                delta = (aim-c_pts(end,:));
                
                
                v = w_normalize(c_pts(end, :) - c_pts(end-1, :));
                delta_or = w_cross(v, orientation);
                
                
                F = [delta(1:3)  delta_or(1:3)*5000]';
                a = w_dot(jjp*F, F);
                a = a/w_dot(jjp*F,jjp*F);
                
                if isnan(a)
                    a = 0;
                end
                q = a*jacobi*F;
                q = q.*enhancement';
                current_gp = current_gp + q';
               delta_prev = abs(w_len(delta_or) - prev_e);
                e = w_len(delta_or);
                
                
                for k = 1:1:length(robot.min)
                    current_gp(k) = min(robot.max(k), max(current_gp(k), robot.min(k)));
                end
%                 errors = [errors,e];
                if delta_prev > 0.01
                    out = [out; current_gp];
                    prev_e = e;
                end
            end
            out = [out; current_gp];
    
%             figure(2)
%             hold on
%             plot(errors, 'k');
%             figure(1)

end

function out = computeEnhancement(zmie)
% wyznacza wzmocnienie konieczne dla przesuwania cz³onów pryzmatycznych, bo
% s¹ za badzo redukowane i zbyt wolno siê poruszaj¹
    out = [];
    for i = 1:1:length(zmie(:,1))
        if w_dot(zmie(i,:), [0 1 1 0]) == 1
            out = [out, 2800];
        elseif w_dot(zmie(i,:), [1 0 0 1]) == 1
            out = [out, 1];
        end
    end
end


