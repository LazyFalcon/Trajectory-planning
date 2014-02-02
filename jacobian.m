function J = w_jacobian(gp, robot)
    num_joints = robot.parts;
    pos = zeros(num_joints,4);
    trans = eye(4);
    T={};
    rows = 0;
    sum = 0;
        for j = 1:1:num_joints
            T{j} = trans;
            pos(j,:) = trans*[0 0 0 1]';
%             w_dot(robot.part(j).module.zmie, [1 1 1 1])
            if w_dot(robot.part(j).module.zmie, [1 1 1 1])== 1
                rows = rows+1;
                trans = trans*substitution(gp(rows), robot.part(j).module);
            else
                trans = trans*substitution(0, robot.part(j).module);
            end
        end
    efector = (trans*[0 0 0 1]')';
    J = zeros(6, rows);
    
    idx = 1;
    for i=1:1:num_joints
        axisZ = w_normalize(T{i}*[0 0 1 0]')';
        axisX = w_normalize(T{i}*[1 0 0 0]')';
        if robot.zmie(i,1) == 1 %  Rx
            J(:,idx) = [(w_cross(axisX, efector-pos(i,:))) (axisX(1:3))]';
            
        elseif robot.zmie(i,2) == 1 % Tx
            J(:,idx) = [(axisX(1:3)) 0 0 0]';
                   
        elseif robot.zmie(i,3) == 1 % Tz
            J(:,idx) = [(axisZ(1:3)) 0 0 0]';
          
        elseif robot.zmie(i,4) == 1 % Rz
            J(:,idx) = [(w_cross(axisZ, efector-pos(i,:))) (axisZ(1:3))]';
        else
%           J(:,i) = [0 0 0 0 0 0 ];
            idx = idx - 1;
        end
        idx = idx +1;
    end
    
    
end