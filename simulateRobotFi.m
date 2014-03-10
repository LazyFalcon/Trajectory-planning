function out = simulateRobotFi(robot, fi)
% przeprowadza symulacjê po³o¿enia efektora robota na podstawie vektora wspo³¿êdnych z³¹czowych
% fi zawiera wartoœci obrotu/przesuniêcia ka¿dego jointa
    out = zeros(length(fi(:,1)),4);
    part = robot.part;
    
    for i = 1:1:length(fi(:,1))
        trans = eye(4);
%         for j = 1:1:length(fi(1,:))
        partval = 1;
        for j = 1:1:robot.parts
            v = part(j).module.val;
            if sum(part(j).module.zmie.*[1 1 1 1]) == 1
                z = part(j).module.zmie * fi(i, partval) + v;
                partval = partval+1;
            else
                z = v;
            end

            trans = trans* [ cos(z(1)), -cos(z(4))*sin(z(1)),  sin(z(1))*sin(z(4)), z(3)*cos(z(1));
                  sin(z(1)),  cos(z(1))*cos(z(4)), -cos(z(1))*sin(z(4)), z(3)*sin(z(1));
                  0,          sin(z(4)),          cos(z(4)),         z(2);
                  0,                0,                0,          1];
        end
%         if length(fi(:,1))~= 1
            out(i,:) = (trans*[0 0 0 1]' + robot.initialPosition')';
%         else 
%             out = (trans*[0 0 0 1]' + robot.initialPosition')';
%         end
    end
    
end
