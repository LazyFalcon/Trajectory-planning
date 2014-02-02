function out = FixWholePath(robot, path, shapes)
% out: fixed path, or if not, bad parts 
    errors = findPathErrors(robot, path, shapes);
    out{2} = errors;
    for i =1:1:1
        fprintf('Znaleziono %d b³êdów\n', length(errors));
        if ~isempty(errors) && ~isempty(path)
            path = resolvePathErrors(robot, errors, path, shapes);
%             if  ~isempty(path)
%                 errors = findPathErrors(robot, path, shapes);
%             end
%             drawPath3d(path, 'b', 2);
        end
    end
    if  ~isempty(path)
        out{1} = Interpolate(path,1,'spline');
    else
        out{1} = [];
    end

    
   