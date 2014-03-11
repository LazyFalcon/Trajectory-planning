function out = simulateRobotFiMatrices(robot, fi)
% wyznacza macierze transformacji na podstawie zadanych fi( przygotowane dla symbolicznych )
    out = {};
    part = robot.part;

        partval = 1;
        for j = 1:1:robot.parts
            v = part(j).module.val;
            if sum(part(j).module.zmie.*[1 1 1 1]) == 1
                z = part(j).module.zmie * fi(partval) + v;
                partval = partval+1;
            else
                z = v;
            end

            trans = [ cos(z(4)), -sin(z(4))*cos(z(1)),  sin(z(4))*sin( z(1)), (z(2))*cos(z(4));
 sin(z(4)),  cos(z(4))*cos(z(1)), -cos( z(4))*sin(z(1)),  (z(2))*sin(z(4));
          0,             sin(z(1)),             cos( z(1)),             (z(3));
          0,                      0,                      0,            1];
      
      out{j} = trans;
        end
        

    
end