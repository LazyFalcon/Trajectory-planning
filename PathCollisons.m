function out = PathCollisons(robot, path, collShapes)
    % wyszukuje w którym miejscu scierzka przecina przedmioty
    % zwraca indeksy punktów w których nast¹pi³o przeciêcie
    out = [];
    if isempty(path)
        return
    end
    len = length(path(:,1));
    for i = 1:1:len
        sphere = Sphere(path(i, :), robot.efector_radius);
        tmp = test(sphere, collShapes);
        if tmp ~= 0
            out = [out; i tmp];
        end
    end
    
    
end

function out = test(sphere, collShapes)
    % sprawdza kolizjê punktu, sfery z przeszkodami
    out = 0;
    for i = 1:1:length(collShapes)
        it = collShapes{i};
        if w_distance(sphere.center, it.center) <= sphere.sph_r + it.sph_r
            if Collision(sphere, it)
                out = i;
                break;
            end
        end
    end
end