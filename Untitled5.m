% resolwing collisions
kol = [];
points = input3D(5);
%%
 for i = 1:1:length(points)
     hold on
     drawPoint3d(points(i,:), 'ko');
 end
 %%
hold on
points = [];
p1 = [25 69 0 1];
    points = [points; p1];

p1 = p1+[25 25 0 0];
    points = [points; p1];
p1 = p1+[25 25 0 0];
    points = [points; p1];
p1 = p1+[25 25 0 0];
    points = [points; p1];
p1 = p1+[25 25 0 0];
%     points = [points; p1];

drawPath3d(NURBS(points), 'k');
drawPath3d(points, 'ko');

%% spline interpolation
interped = SplineInterpolation(points);
drawPath3d(interped, 'k');
%%

result = generateFixedPath(robot, interped, shapes);
%%
drawPath3d(result,'k',1);
hold on
% drawPath3d(interped);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% resolve robot collisons
% compute gps
    gpIndicesSpacing = 10; % sprawdamy co 10¹ konfiguracjê, leniwy jestem
    resp = computeGP(robot, result, gpIndicesSpacing, 0.01, 200);
     gps = resp{1}; % wspó³¿êdne punktów osi¹gniêtych
    bad_indices = resp{2}; % punkty nieosi¹galne
% najpierw nale¿y poprawiæ punkty tak by by³y osi¹galne
    %%
    hold on
    drawPath3d(result(firstGoodInd:lastGoodInd,:),' k',0.5);
    
    %% wykrycie stref nieosiagalnych
    % obciêcie stref poczatkowych i koñcowych, te nigdy nie bed¹ osi¹galne
    firstGoodInd = 1;
    lastGoodInd = length(result);
    if bad_indices(1) == 1
        for i = 2:1:length(bad_indices)
            if bad_indices(i) ~= firstGoodInd+1
                break;
            end
            firstGoodInd = bad_indices(i);
        end
    end
    
    if bad_indices(end) == length(result);
        for i = length(bad_indices)-1 : -1 : 1
            if bad_indices(i) ~= lastGoodInd-gpIndicesSpacing
                break;
            end
            lastGoodInd = bad_indices(i);
        end
    end
    %% partitioning
    parts = {};
    tmp =[];
    indices = bad_indices;
    % wykryæ i oddzieliæ 
    for i = 2:1:length(indices)
        if indices(i) ~= indices(i-1) +1
            parts{end+1} = tmp;
            tmp = [];
        end
        tmp = [tmp; response(i,:)];
    end
    parts{end+1} = tmp;
    %% resolwing path for each part
    % wyznaczane s¹ punkty, w pewnej odleg³oœci od punktów ostatnich, lub
    % te ostanie
    % wyznaczana jest prosta i plaszczyzna na której prosta le¿y, pomiêdzy
    % tymi punktami
    % 
    % na p³aszczyŸnie wybierane s¹ punkty lez¹ce po oby stronach prosstej
    % nastepnie wyszukiwana jest optymalna trasa przechodz¹ca przez punkty
    % le¿¹ce w przestrani roboczej, NIE DZIA£A DLA ORIENTACJI, TA MUSI BYÆ
    % JU¯ PRZEMYŒLANA
    % punkty wybieramy po drugiej stronie prostej ni¿ punkty poprawne, lub
    % po losowej
    
    