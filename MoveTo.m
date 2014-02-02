function out = MoveTo(robot, pointA, pointB, shapes, YZexpand, size)
    % funkcja wyznacza w miarê bezkolizyjna trasê pomiêdzy punktami
    % YZexpand okresla jak bardzo rozsze¿y siê szeœcian przestrzeni w
    % algorytmie A*, size okreœla iloœæ wêz³ów na osi
    
    % zwraca
    % 1 - po interpolacji krzyw¹
    % 2- po aproksymacji BSplajnem
    % 3- wêz³y scierzki

    resp = jacobi_IK(robot, robot.bindGP, pointA, 0.01, 500);
    initGP = resp{1};
    
    nodes = AStarDeformed(robot, pointA, pointB, shapes, size, YZexpand, initGP);
    
    if ~isempty(nodes)
        out{1} = SplineInterpolation(nodes);
        out{2} = NURBS(nodes);
        out{3} = nodes;
    else
        out = [];
        fprintf('\nNie uda³o siê znaleŸæ  trasy\n');
    end
    
end