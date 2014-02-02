function vec = drawRobot(robot, gp, str, gr, drawAxes, transform)
%     rysuje robota
%     gp: pozycja w którem ma byc narysowany
%     str, gr: ~~
% 		transform jest nieu¿ywalana, wartoœæ jedynie testowa0 
% drawAxes: rysuje osie uk³adu wspó³¿ednych lokalne, first rysuje osie
% doko³a których wykonuj¹ siê przekszta³cenia, last rysuje osie lokalne


    if nargin<3
       str = 'k';
       gr = 3;
       transform = eye(4);
       drawAxes = 'none';
    elseif nargin<4
       gr = 3;
       transform = eye(4);
       drawAxes = 'none';
    elseif nargin<5
       transform = eye(4);
       drawAxes = 'none';
    elseif nargin < 6
       transform = eye(4);
    end
    
        p2 = robot.initialPosition';
        p1 = transform*[0 0 0 1]' + robot.initialPosition';
        trans = transform;
        vec = zeros(0,4);
        point = zeros(0,4);
        
            hold on  
            idx = 1;
    for i = 1:1:robot.parts;        
            
             if robot.part(i).module.zmie(2)==1 ||robot.part(i).module.zmie(3)==1
              drawPoint3d(p1, 'bs', gr);
              
            elseif robot.part(i).module.zmie(1)==1 
              drawPoint3d(p1, 'bo', gr);
              
            elseif  robot.part(i).module.zmie(4)==1
              drawPoint3d(p1, 'bo', gr);
            end
            if strcmp(drawAxes, 'first')
                x = w_normalize((trans*[1 0 0 0]')');
                y =w_normalize( (trans*[0 1 0 0]')');
                z = w_normalize((trans*[0 0 1 0]')');
                drawLine3d(p1, p1' + x*75,'r',2.5);
                drawLine3d(p1, p1' + y*75,'g',2.5);
                drawLine3d(p1, p1' + z*75,'b',2.5);
            end
            if w_dot(robot.part(i).module.zmie, [1 1 1 1]) == 1
                trans = trans*substitution(gp(idx), robot.part(i).module);
                idx = idx +1;
            else
                trans = trans*substitution(0, robot.part(i).module);
            end
					 
            p2 = trans*[0 0 0 1]' + robot.initialPosition';
            drawLine3d(p1,p2, str, gr);
            
            if strcmp(drawAxes, 'last')
                x = w_normalize((trans*[1 0 0 0]')');
                y =w_normalize( (trans*[0 1 0 0]')');
                z = w_normalize((trans*[0 0 1 0]')');
                drawLine3d(p1, p1' + x*75,'r',2.5);
                drawLine3d(p1, p1' + y*75,'g',2.5);
                drawLine3d(p1, p1' + z*75,'b',2.5);
            end
                    
        
        vec(i,:) = p2;
        point(1,:) = p1;
        p1 = p2;
    end
 
    
    point(2,:)=p2;
end
