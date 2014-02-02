function out = SmoothPath(path)
len = length(path);
out = [];
d = 20; % mm


    if ~strcmp(path{end}.type, 'final')
        point = path{end}.point;
        path{end+1}.point = point;
        path{end}.type = 'line';
        path{end}.w = 0;
        path{end}.delay = 0;
        
    end

    t= 0:0.02:1;
    prev = path{1};
    point = [];
    
    
    circle.points = [0 0 0 1];
    circle.center = [0 0 0 1];
    circle.plane = [0 0 0 1];
     circle.normal = [0 0 0 1];
    circle.r = -10;
    bezier = [];
    p_point = [0 0 0 1];
    
    
for i = 1:1:len
    it = path{i};
    next = path{i+1};
    if strcmp(it.type, 'line')
      %%
      a = p_point;
      b = it.point;
      t_vec = w_normalize(b - a);% wektor z punktu a do b, tworz¹cy liniê
      
      ap = a + t_vec*it.delay; % punkt a odsuniety o odleg³oœæ okreœlon¹ w strukturze
      bp = b - t_vec*next.delay;
      bezier = [bezier; a(1:3) it.w; ap]; % zaokr¹glenie
      
%       drawPoint3d(bezier(1,:), 'o',2)
%       drawPoint3d(bezier(2,:), 'o',2)
%       drawPoint3d(bezier(3,:), 'o',2)
      % rysujemy beziera
       bezier_points = bezier3(bezier, t,2);
%       bezier_points = doSomething(circle, bezier_points);
        % DEBUG
%           hold on
%           drawPoint3d(p_point,'k+');
          
      t_len = w_distance(ap, bp);
         
      % odstepy pomiêdzy punktami
      t_spacing = 1;
      % iloœæ punktów na linii
      t_count = floor(t_len/t_spacing);
      
      points = zeros(t_count, 4);
      
      
      for j = 1:1:t_count
        points(j,:) = ap + t_vec*t_spacing*j;
      end
      
      out = [out; bezier_points; points];
      
      p_point = it.point;
      bezier = [bp];
      circle.points = [0 0 0 1];
      circle.center = [0 0 0 1];
      circle.plane = [0 0 0 1];
      circle.normal = [0 0 0 1];
      circle.r = -10;
      
      
    elseif strcmp(it.type, 'arc')
       %%
        a = p_point; %pocz¹tek ³uku
        b = it.point(1,:);% punkt na ³uku
        c = it.point(2,:);%koniec ³uku
        
        circle = computeCircle(a,b,c,it.delay,next.delay);
        bezier = [bezier; a(1:3) it.w;  circle.points(1,:)];
%         hold on
%       drawPoint3d(a, 'm+')
%       drawPoint3d(bezier(1,:), 'm+',5)
%       drawPoint3d(bezier(2,:), 'ko',5)
%       drawPoint3d(bezier(3,:), 'yo',5)
        bezier_points = bezier3(bezier, t,2);
%         bezier_points = doSomething(circle,bezier_points);
        out = [out; bezier_points; circle.points];
        bezier = [circle.points(end,:)];
        p_point = c;
        
    elseif strcmp(it.type, 'initial')
        bezier = [it.point(1:3) 1];
        p_point = it.point;
        out = it.point;
    elseif strcmp(it.type, 'final')
        
    end
end

    
    out = Interpolate(out);
end

function circle = computeCircle(a,c,b,da,db)
 
        plane = w_plane(a, c, b);
        normal = w_normalize([plane(1:3) 0]);
        x = w_normalize(a-b);
        y = [w_cross(normal, x) 0];
      
        const_cross = 2*w_len(w_cross(a-b, b-c))^2;

        alfa = w_len(b - c)^2 *w_dot((a-b),(a-c))/const_cross;
        beta = w_len(a - c)^2 *w_dot((b-a),(b-c))/const_cross;
        gamma = w_len(a - b)^2 *w_dot((c-a),(c-b))/const_cross;
        center = alfa*a + beta*b + gamma*c;
        r = w_len(a- center);

        A = center + r*x;
        A_p = A + r*y;
        B = center - r*x;
        B_p = B + r*y;
        C = center +r*y;
        
%         drawPoint3d(a,'ro');
%         drawPoint3d(A_p,'r+');
%         drawPoint3d(b,'go');
%         drawPoint3d(B_p,'g+');
        
        w = sqrt(2)/2;

        b1 = [A; A_p(1:3) w; C];
        b2 = [C; B_p(1:3) w; B];

        t = 0:0.01:1;
      points = bezier3(b1,t,2);
      points = [points; bezier3(b2,t,2)];
      
      % obcinanie wystajacych czêœci
      da = da +w_distance(a,A);
      db = db + w_distance(b, B);
      idxa = 1;
      idxb = length(points);

      for i = 1:1:length(points)
        if w_distance(A, points(idxa,:)) < da
          idxa = idxa +1;
        else
          break;
        end
      end
      for i = length(points):-1:1
        if w_distance(B, points(idxb,:)) < db
          idxb = idxb -1;
        else
          break;
        end
      end

      out = [points(idxa:1:idxb, :)];
      circle.points = out;
      circle.center = center;
      circle.plane = plane;
      circle.normal = normal;
      circle.r = r;
end

function out = doSomething(circle, points)
    for i = 1:1:length(points(:,1))
      z = w_dot(circle.plane, points(i,:));  
      pp = points(i,:)-circle.normal*z;
      d = w_distance(pp, circle.center);
      
      if d<circle.r
          t_v = w_normalize( pp-circle.center);
          points(i,:) = circle.center +t_v*circle.r+circle.normal*z;
      end
    end
    out = points;
end

function computeMinMax(path)
     dstncs = zeros(length(path(:,1))-1, 1);
    for i = 1:1:length(path(:,1))-1
        dstncs(i) = w_distance(path(i,:), path(i+1,:));
    end
    w_max = max(dstncs);
    w_min = min(dstncs);
    w_mean = mean(dstncs);
    fprintf('count: %d,min: %f, max: %f, mean: %f\n',length(path(:,1)), w_min, w_max, w_mean);
end


