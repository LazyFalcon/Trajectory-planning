function out = computeGP(robot, points, delay, error, limit, print)
    

    bad_indices = [];
    gps = [];
    out{1} = gps;
    out{2} = bad_indices;
    if isempty(points)
        return
    end
    if nargin<4
        limit = 600;
        error = 0.05;
        print = false
    elseif nargin<5
      limit = 600;
      print = false;
    elseif nargin < 6
        print = false;
    end
    
    current_gp = robot.bindGP;
    reverseStr = '';
    if print
        fprintf('\nInverse kinematics\n');
    end
%     gps = zeros(length(points(:,1)), length(current_gp));
    len = length(points(:,1));
    
    for i = 1:delay:len
    response = jacobi_IK(robot, current_gp, points(i,:), error, limit);
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