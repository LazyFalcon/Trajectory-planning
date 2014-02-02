function path = Arc(path, pointA, pointB, w, delay)
    % wykonuje  ³uk pomiêdzy ostatnim punktem ze scie¿ki poprzez punkt
    % pierwsz, koñczy w punkcie ostatnim
    % by³ podany jest to aktualan a pozycja robota
    
    if nargin  <4
        w = 0.7;
        delay = 80;
    elseif nargin <5
        delay = 80;
    end
    
    
    
    path{end+1}.point = [pointA; pointB];
    path{end}.type = 'arc';
    path{end}.w = w;
    path{end}.delay = delay;
    
end
