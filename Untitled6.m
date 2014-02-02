function fixed = fixPath(path, shapes, indices)
%% partitioning
parts = {};
tmp =[];

% wykryæ i oddzieliæ 

for i = 2:1:length(indices)
    if indices(i) ~= indices(i-1) +1
        parts{end+1} = tmp;
        tmp = [];
    end
    tmp = [tmp; presponse(i,:)];
end
    parts{end+1} = tmp;
    
%% odsuwanie
    tresult = result;
for i = 1:1:length(parts)
    it = parts{i};
    istart = it(1, 1);
    iend = it(end, 1);
    imid = ceil((istart + iend)/2);
    center = shapes{it(1,2)}.center;
    shape = shapes{it(1,2)};
    
   nvec = w_normalize(result(imid,:) - center);
    
    istart = istart - 10;
    iend = iend + 10;
    
    iloscPunktow = iend - istart;
    % odsuñmy punkt œrodkowy na bezpieczn¹ odleg³oœæ:
    pmid = sum(result(istart:iend,:));
    pmid = pmid/pmid(4);
    tpmid = pmid;
    alfa = (shape.sph_r - w_distance(pmid, center))/70;
    
%     drawPoint3d(pmid, 'ro',4)
    while ~isempty( PathCollisons(robot, [pmid], shapes))
        pmid = pmid + nvec*alfa;
    end
%     drawPoint3d(pmid, 'ro',4)
    % odleg³oœæ o jak¹ odsuniêto punkt
    distance = w_distance(pmid, tpmid);
    
    % krzywa odsuniêæ?
    t = 0: 1/iloscPunktow*2: 1;
        bez = [
            0 0 0 1; 
            1 0 0 0.3; 
            0 1 0 0.4;
            1 1 0 1
            ];
    points = bezier4(bez, t, 3);
    % interesuj¹ nas tylko wartoœci y krzywej
    curve = points(:,2)*distance;
    curve = [curve', curve(end-1:-1:1)'];
    % odsuwamy punkty o wartoœæ tej krzywej
    
    for j = 1:1:iend - istart
        tresult(istart+j,:) = tresult(istart+j,:) + nvec * curve(j);
    end
end

%%
figure(2)
drawPath3d(tresult,' r',1);
hold on
drawPath3d(result,' k',1);
        drawCollShape(shapes{1});
        drawCollShape(shapes{2});
end