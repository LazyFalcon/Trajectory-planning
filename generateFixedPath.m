function out = generateFixedPath(robot, path, shapes)
% path: w postaci punktów, to co zwraca smoothPath
limit = 5;    
i = 0;
terminate = false;
% test wstêpny
response  = PathCollisons(robot, path, shapes);
if isempty(response)
    terminate = true;
end
indices = response(:,1);

fixedPath = fixPath(robot, path, response, shapes, indices);

while ~terminate && i<limit
    i = i+1;
    
    response  = PathCollisons(robot, fixedPath, shapes);
    if isempty(response)
        terminate = true;
    else
        indices = response(:,1);
        fixedPath = fixPath(robot, fixedPath, response, shapes, indices);
    end
end

    if terminate == false
        fprintf('Nie ua³o siê poprawiæ wszystkich kolizji, konieczna jest rêczna poprawka');
    end
    out = Interpolate(fixedPath);
end