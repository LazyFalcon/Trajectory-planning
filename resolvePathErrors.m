function out = resolvePathErrors(robot, errors, path, shapes)
    out = [];
    
    if isempty(path) || isempty(errors)
        return
    end

    l= 1;
    for ierr = 1:1:length(errors)
%     for ierr = 1:1:1
       result=  resolveSingleError(robot, errors{ierr}, path, shapes);
       out = [out; path(l:result{1},:); result{3}];
       l = result{2};
    end
    
    out = [out; path(l:end,:)];
    % teraz trzeba wyj¹æ ze scie¿ki nieruszane fragmenty i posklejaæ to z
    % tym co jest w result
    % maj¹c indeksy z result nie bêdzie problemu

    
end

function out = resolveSingleError(robot, error, path, shapes)
% znaleŸæ punkty oddalone od strefy erroru o kilka punktów
%    punkt nie mo¿e byæ w innej strefie, nie mo¿e wychodziæ poza scie¿kê

delay = min(20, w_distance(path(error(1) ,:),path(error(end) ,:)/4)); % mm
if length(error) < 20
    delay = 35;
end
    i1 = error(1);
    if error(1)  < 3
        i1 = 1;
    else 
        i1 = i1 - 2;
    end
    
    ie = error(end);
    if error(end)  > length(path(:,1))-3
        ie = length(path(:,1));
    else 
        ie = ie + 2;
    end
    
    a = path(i1 ,:);
    b = path(ie ,:);
    vec = w_normalize(b-a);
    
    if error(1)  < delay
        i1 = 1;
    else 
        i1 = i1 - delay;
    end
    
    ie = error(end);
    if error(end)  > length(path(:,1))-delay
        ie = length(path(:,1));
    else 
        ie = ie + delay;
    end
    

    
%     a = a + vec*25;
%     b = b - vec * 25;
    
    % wyszukujemy wêz³y 
    nodes = AStar(robot, a,b, shapes, 7);
    
    % wsadzamy scie¿kê
    if ~isempty(nodes)
    %     nodes = [path(i1:5:error(1)-10, :); nodes; path(error(end)+10:2:ie, :)];
    %     nodes = [path(i1, :); nodes; path(ie, :)];
%         drawPath3d(nodes, 'ko', 1);
%         hold on
        fixInterp = SplineInterpolation(nodes);
        length(fixInterp);
        fixInterp = fixInterp(delay:end-delay,:);
        
%         hold on
%         drawPath3d(fixInterp, 'k', 1);
%         drawPath3d(path(i1:2:error(1)-ceil(delay/2), :), 'k', 1);
%         drawPath3d(path(error(end)+ceil(delay/2):2:ie,:), 'k', 1);
        fixInterp = [path(i1:2:error(1)-ceil(delay/2), :); fixInterp; path(error(end)+ceil(delay/2):2:ie,:)];
        fixInterp = Interpolate(fixInterp,1,'spline');
%         drawPath3d(fixInterp, 'b', 2);
%         drawPath3d(Interpolate(fixInterp(1:5:end, :),1,'spline'), 'k', 1);
        out{1} = i1;
        out{2} = ie;
        out{3} = fixInterp;
    else
        out{1} = i1;
        out{2} = ie;
        out{3} = [];
    end
end
