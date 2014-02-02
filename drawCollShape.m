function drawCollShape(collShape, str, gr)
% rysuje ksztalt kolizyjny,sciany maj¹ alfê 0.5
    if nargin<2
       str='b';
       gr=0.5;
    elseif nargin<3
        gr=0.5;
    end
    alfa = 0.5;
    
    if strcmp(collShape.type, 'box')
        %%
        o = collShape.center;
        x = collShape.axis(1, :) * collShape.dimensions(1) * 0.5;
        y = collShape.axis(2, :) * collShape.dimensions(2) * 0.5;
        z = collShape.axis(3, :) * collShape.dimensions(3) * 0.5;
        
        a = o + x + y + z;
        b = o + x + y - z;
        c = o + x - y +-z;
        d = o + x - y + z;
        
        e = o - x + y + z;
        f = o - x + y - z;
        g = o - x - y - z;
        h = o - x - y + z;

        points = [a;b;c;d;e;f;g;h];
        A = [a;b;c;d];
        B = [e;f;g;h];
        C = [a;b;f;e];
        D = [c;d;h;g];
        E = [a;d;h;e];
        F = [b;c;g;f];
        hold on
        fill3(A(:,1), A(:,2), A(:,3), str, 'FaceAlpha', alfa);
        fill3(B(:,1), B(:,2), B(:,3), str, 'FaceAlpha', alfa);
        fill3(C(:,1), C(:,2), C(:,3), str, 'FaceAlpha', alfa);
        fill3(D(:,1), D(:,2), D(:,3), str, 'FaceAlpha', alfa);
        fill3(E(:,1), E(:,2), E(:,3), str, 'FaceAlpha', alfa);
        fill3(F(:,1), F(:,2), F(:,3), str, 'FaceAlpha', alfa);
        
    elseif strcmp(collShape.type, 'sphere')
        %%
         [x,y,z] = sphere;      %# Makes a 21-by-21 point sphere
            r = collShape.r;  
            x = r.*x;       %# Keep top 11 x points
            y = r.*y;       %# Keep top 11 y points
            z = r.*z;       %# Keep top 11 z points
        
            points = [];
            for i = 1:1:21
                for j = 1:1:21
                    points = [points; [x(i,j) y(i,j) z(i,j) 1]];
                end
            end
            p = collShape.center;
            for i = 1:1:length(points)
                points(i,:) = points(i,:) + p;
            end
            it = 0;
               for i = 1:1:11
                for j = 1:1:21
                    it = it+1;
                    x(i,j) = points(it,1);
                    y(i,j) = points(it,2);
                    z(i,j) = points(it,3);
                end
               end
               
            hSurface =  surface(x,y,z);
            set(hSurface,'FaceColor',str,'FaceAlpha',alfa,'EdgeAlpha', 0);
               
    elseif strcmp(collShape.type, 'capsule')
        %%
        [x,y,z] = sphere;      %# Makes a 21-by-21 point sphere
            r = collShape.r;  
            xu = r.*x(11:end,:);       %# Keep top 11 x points
            yu = r.*y(11:end,:);       %# Keep top 11 y points
            zu = r.*z(11:end,:);       %# Keep top 11 z points
            % 
            xd = r.*x(1:11,:);       %# Keep top 11 x points
            yd = r.*y(1:11,:);       %# Keep top 11 y points
            zd = r.*z(1:11,:);       %# Keep top 11 z points
            
            % wyciagamy punkty

            points_up = [];
            points_down = [];
            for i = 1:1:11
                for j = 1:1:21
                    points_up = [points_up; [xu(i,j) yu(i,j) zu(i,j) 1]];
                    points_down = [points_down; [xd(i,j) yd(i,j) zd(i,j) 1]];
                end
            end

            % teraz obracamy punkty i odsuwamy
            p1 = collShape.p1;
            p2 = collShape.p2;
            vec = w_normalize(p2 -p1);

            % wyznaczamy uk³ad wspó³zednych
                if isequal(vec, [0 0 1 0])
                    xp = [1 0 0 0];
                    yp = [0 1 0 0];
                    zp = [0 0 1 0];
                else
                    planeXY = [0 0 1 0];
                    dist = w_dot(planeXY, vec);

                    zp = w_normalize(vec - [0 0 -1 0]*dist);
                    zp = vec;
                    yp = [w_normalize(w_cross([0 0 1 0], zp)) 0];

                    xp = [w_normalize(w_cross(vec, yp)) 0];

                    out = [xp; yp;vec];
                end


                % macierz transformacji
                transform = [xp;yp;zp;[0 0 0 1]]';
            %     transform = [xp',yp',zp',[0 0 0 1]']'

            %     b1 = transform*[50 0 0 1]';
            % drawPoint3d(b1,'k+')
                % 

                %wyciagamy
            points_up = [];
            points_down = [];
            for i = 1:1:11
                for j = 1:1:21
                    points_up = [points_up; [xu(i,j) yu(i,j) zu(i,j) 1]];
                    points_down = [points_down; [xd(i,j) yd(i,j) zd(i,j) 1]];
                end
            end
            %     transformujemy wszystkie punkty
            for i = 1:1:length(points_up)
                point = transform*points_up(i,:)';
                points_up(i,:) = point' + p2;
            end

            for i = 1:1:length(points_down)
                point = transform*points_down(i,:)';
                points_down(i,:) = point' +p1;
            end

            %
            x1 = zeros(11,21);
            y1 = zeros(11,21);
            z1 = zeros(11,21);

            x2 = zeros(11,21);
            y2 = zeros(11,21);
            z2 = zeros(11,21);
            it = 0;
            for i = 1:1:11
                for j = 1:1:21
                    it = it+1;
                    x1(11 - i +1,j) = points_up(it,1);
                    y1(11 - i +1,j) = points_up(it,2);
                    z1(11 - i +1,j) = points_up(it,3);

                    x2(11 - i +1,j) = points_down(it,1);
                    y2(11 - i +1,j) = points_down(it,2);
                    z2(11 - i +1,j) = points_down(it,3);
                end
            end
            % robimy cylinder
            j = 1;
            xc  = zeros(2,21);
            yc = zeros(2,21);
            zc= zeros(2,21);

            for i = 1:1:21
                xc(i,j) = x2(1,i);
                yc(i,j) = y2(1,i);
                zc(i,j) = z2(1,i);
            end
            j = 2;
            for i = 1:1:21
                xc(i,j) = x1(1,i);
                yc(i,j) = y1(1,i);
                zc(i,j) = z1(1,i);
            end

            % rysujemy
            hSurface =  surface([x1; x2],[y1; y2],[z1; z2]);
            set(hSurface,'FaceColor',str,'FaceAlpha',alfa,'EdgeAlpha', 1);
    end
end