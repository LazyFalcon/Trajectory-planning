function out = testNode(robot, point, shapes, GP)
% true, jeœli punkt jest dobry
    if nargin < 4
        GP = robot.bindGP;
    end
    out = false;
    error = 0.1; % mm
    limit = 300; % iteracji
    response = jacobi_IK(robot, GP, point, error, limit);
    if response{2} == 0
        gp = response{1};
    else
        out = false;
%         drawPoint3d(point,'r*');
        return;
    end
    
    if testPointCollision(robot, point, shapes)
        out = false;
%         drawPoint3d(point,'g.');
        return;
    end
    
    if  testRobotCollision(robot, point, shapes, gp)
        out = false;
%         drawPoint3d(point,'m^');
        return;
    end
    
    out = true;
end


function out = testPointCollision(robot, point, shapes)
    out = true;
    response  = PathCollisons(robot, point, shapes);
    if isempty(response)
        out = false;
    end
end

function out = testRobotCollision(robot, point, shapes, gp)
        out = true;
        response = collisionTest(robot, gp, shapes);
        if isempty(response)
            out = false;
        end
    end