function out = simulateRobotFi2(robot, fi)
% przeprowadza symulacjê po³o¿enia efektora robota na podstawie vektora wspo³¿êdnych z³¹czowych
% fi zawiera wartoœci obrotu/przesuniêcia ka¿dego jointa
    out = [];
    out = [0 0 0 1];
    part = robot.part;
        trans = eye(4);
        partval = 1;
        for j = 1:1:robot.parts
            v = part(j).module.val;
            if sum(part(j).module.zmie.*[1 1 1 1]) == 1
                z = part(j).module.zmie * fi(partval) + v;
                partval = partval+1;
            else
                z = v;
            end
            trans = trans*[ cos(z(1)), -cos(z(4))*sin(z(1)),  sin(z(1))*sin(z(4)), z(3)*cos(z(1));
                  sin(z(1)),  cos(z(1))*cos(z(4)), -cos(z(1))*sin(z(4)), z(3)*sin(z(1));
                  0,          sin(z(4)),          cos(z(4)),         z(2);
                  0,                0,                0,          1];
            out = [out; (trans*[0 0 0 1]' + robot.initialPosition')'];
        end

    
end