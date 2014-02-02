function shape = rotShape(shape, transform, point, delay, initial, drawAxes)
    if nargin == 4
        delay = [0 0 0 0];
        drawAxes = false;
    elseif nargin == 5
        drawAxes = false;
    end
            trans = [1 0 0 delay(1);
                0 1 0 delay(2);
                0 0 1 delay(3);
                0 0 0 1];
            trans = transform * trans;
            
            if strcmp(shape.type, 'box')
                  
                   a = point+(transform*delay')';
                   b = (transform*[0 0 0 1]' +transform*delay')';
                   vec = w_normalize(b-a);
                   
                   % 
                   x = w_normalize((transform*[1 0 0 0]')');
                   y =w_normalize( (transform*[0 1 0 0]')');
                   z = w_normalize((transform*[0 0 1 0]')');
                    if drawAxes
                        drawLine3d(point +vec*2, point + x*150,'r',2);
                        drawLine3d(point +vec*2, point + y*150,'g',2);
                        drawLine3d(point +vec*2, point + z*150,'b',2);
                    end
                   
                   p1 = (a+b)/2 - vec*shape.dimensions(1)/2;
                   p2 = (a+b)/2 + vec*shape.dimensions(1)/2;
                   shape = OOBB(p1+initial, p2+initial, shape.rot, shape.dimensions(2), shape.dimensions(3), [x;y;z]);
               
               
               
            elseif strcmp(shape.type, 'sphere')
                shape.center = (trans * sphere.center')' + initial;
                
            elseif strcmp(shape.type, 'capsule')
                a = point+(transform*delay')';
                b = (transform*[0 0 0 1]'+transform*delay')';
                
                len = w_distance(shape.p1, shape.p2);
                
                vec = w_normalize(b-a);
                
                p1 = (a+b)/2 - vec*len/2;
                p2 = (a+b)/2 + vec*len/2;
                 
                shape.center = (trans * shape.center')';
                shape.p1 = p1+initial;
                shape.p2= p2+initial;
                
                
            end
end

function out = computeAxes(vec)
%     rzutujemy na p³aszczyznê XY
    if isequal(vec, [0 0 1 0])
            out = [
            1 0 0 0;
            0 1 0 0;
            0 0 1 0
            ];
        return
    end
    planeXY = [0 0 1 0];
    dist = w_dot(planeXY, vec);
    
    xp = w_normalize(vec - [0 0 -1 0]*dist);
    yp = [w_normalize(w_cross([0 0 1 0], xp)) 0];
    
    zp = [w_normalize(w_cross(vec, yp)) 0];
    
    out = [vec; yp;zp];
end
