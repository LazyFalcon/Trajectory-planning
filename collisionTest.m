function out = collisionTest(robot, gps, shapes, print)
    % dla kazdej konfiguracji sprawdzamy kolizje robota z otoczeniem
    % 11:20 wypad!
    % dla ka¿dej konfiguracji, dla ka¿dego cz³onu 
    % na wyjœciu jest tablica zawieraj¹ca indeks punku, cz³onu, kszata³u
    % dla których zasz³a kolizja
    
    out = [];
    if isempty(gps)
        return
    end
    
    if nargin < 4
        print = false;
    end
    len = length(gps(:,1));
    if print
        fprintf('\nCollison test\n');
        reverseStr = '';
    end
    for i =1:1:len % dla ka¿dej konfiguracji\
        transform = eye(4);
       point = [0 0 0 1];
       idx = 1;
        for q = 1:1:robot.parts % dla ka¿dego cz³onu
            if w_dot(robot.part(q).module.zmie, [1 1 1 1]) == 1
                transform = transform*substitution(gps(i, idx), robot.part(q).module);
                idx = idx +1;
            else
                transform = transform*substitution(0, robot.part(q).module);
            end
            shape = rotShape(robot.shape{q}, transform, point, robot.shapeDelay{q},robot.initialPosition);
            
            point = (transform * [0 0 0 1]')';
%             drawCollShape(shape);
            
            num = test(shape, shapes);
            if num ~= 0 % zasz³a kolizja
                out = [out; i q num];
            end
        end
%     
%     msg = sprintf('Processed %d / %d', i, len);
%     fprintf([reverseStr, msg]);
%     reverseStr = repmat(sprintf('\b'), 1, length(msg));
    
    end
    if print
        fprintf('done, collisions: %d\n', length(out));
    end
end


function out = test(shape, shapes)
% zwraca indeks shapes'a z którym dosz³o do kolizji(pierwszego z napotkanych)
% jeœli nic nie znalaz³o to zero
    out = 0;
    for i = 1:1:length(shapes)
        it = shapes{i};
        if w_distance(it.center, shape.center) <= it.sph_r + shape.sph_r
            if Collision(it, shape)
                out = i;
                break;
            end
        end
        
    end


end
