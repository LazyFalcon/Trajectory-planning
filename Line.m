function path = Line(path, point, w, delay)
    % wykonuje  ruch po linii od ostatniego podanego punktu, gdy punkt nie
    % by³ podany jest to aktualan a pozycja robota
    
    if nargin< 3
        w = 0.7;
        delay = 70;
    elseif nargin < 4
        delay = 70;
    elseif nargin < 5
    end
    
    
    
    path{end+1}.point = point;
    path{end}.type = 'line';
    path{end}.w = w;
    path{end}.delay = delay;
    
end

