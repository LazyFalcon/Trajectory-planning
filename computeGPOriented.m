function out = computeGPOriented(robot, points, orientation, delay, error, limit, print)
% Description
% .........................................................................
% Autor:                    Karol Wajs
% Date updating:            23.01.2014 r
%
% .........................................................................
% 
% 
% 
% 
%
% Input data:
% robot
% points
% orientation
% delay - co który punkt policzyæ
% error - dla jacobi_ik, precyzja
% limit - dla jacobi_ik
% print - boolean 
%
% Output data:
% gps dla punktów 1:delay:end
% 
% .........................................................................

    bad_indices = [];
    gps = [];
    
    if nargin<5
        limit = 600;
        error = 0.01;
        print = false;
    elseif nargin<6
      limit = 600;
      print = false;
    elseif nargin < 7
        print = false;
    end
    
    current_gp = robot.bindGP;
    reverseStr = '';
    if print
        fprintf('Inverse kinematics\n');
    end
%     gps = zeros(length(points(:,1)), length(current_gp));
    len = length(points(:,1));
    
    orientationGPs = Orient(robot, current_gp, orientation);
    gps = orientationGPs;
    current_gp = orientationGPs(end,:);
    
    for i = 1:delay:len
        
        response = jacobi_IK_oriented(robot, robot.bindGP, points(i,:), orientation ,error, limit);
        if response{2} == 0
            current_gp = response{1};
        else
            bad_indices = [bad_indices, i];
        end
            gps = [gps; current_gp];
         if print
            msg = sprintf('Processed %d / %d', i, len);
            fprintf([reverseStr, msg]);
            reverseStr = repmat(sprintf('\b'), 1, length(msg));
         end
    end
    
    out{1} = gps;
    out{2} = bad_indices;
    if print
        fprintf('\nIK done, points not reached: %d\n', length(bad_indices));
    end
end