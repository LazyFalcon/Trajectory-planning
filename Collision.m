function out = Collision(a, b)
% Description
% .........................................................................
% Autor:                    Karol Wajs
% Date updating:            23.01.2014 r
%
% .........................................................................
% function checks collision between two objects
% 
% 
% 
%
% Input data:
% two collision shapes
% 
% 
% 
% 
% 
% Output data:
% true if collision
% 
% .........................................................................

%%



        out = false;
        if strcmp(a.type, 'box')        
                if strcmp(b.type, 'sphere')
                        out = sphereBox(a,b);
                        
                elseif strcmp(b.type, 'box')
                        out = boxBox(a,b);
                        
                elseif strcmp(b.type, 'capsule')
                        out = capsuleBox(a,b);
                        
                end
                
        elseif strcmp(a.type, 'sphere')
                if strcmp(b.type, 'sphere')
                        out = sphereSphere(a,b);
                        
                elseif strcmp(b.type, 'box')
                        out = sphereBox(a,b);
                        
                elseif strcmp(b.type, 'capsule')
                        out = sphereCapsule(a,b);
                        
                end
                
        elseif strcmp(a.type, 'capsule')
                if strcmp(b.type, 'sphere')
                        out = sphereCapsule(a,b);
                        
                elseif strcmp(b.type, 'box')
                        out = capsuleBox(a,b);
                        
                elseif strcmp(b.type, 'capsule')
                        out = capsuleCapsule(a,b);
                        
                end
        end
end


function out = sphereSphere(shapeA, shapeB)
        %% collision
        out = false;
        if w_distance(shapeA.center, shapeB.center) < shapeA.r + shapeB.r
                out = true;
        end
end

function out = sphereCapsule(shA, shB)

        if strcmp(shA.type, 'sphere')
             shapeA = shA;
             shapeB= shB;
        else
             shapeA = shB;
             shapeB= shA;
        end
out = false;
len = w_len(w_cross(shapeA.center - shapeB.p1, shapeB.p1 - shapeB.p2));
        if len < shapeA.r + shapeB.r
                out = true;
                % sprawdzenie czy nie jest to kontakt fa³szywy
                d1 = w_distance(shapeA.center, shapeB.p1);
                d2 = w_distance(shapeA.center, shapeB.p2);
                l = w_distance(shapeB.p2, shapeB.p1);
                srt = sort([d1 d2 l]); % rosn¹co
                a = srt(1);
                b = srt(2);
                c = srt(3);
                
                if c^2 < a^2 + b^2 % jesli jest rozwartok¹tny to nie
                        out = false;
                end
        end
end

function out = sphereBox(shA, shB)
        %dot(point, plane) : odleg³oœæ punktu od p³aszczyzny, wzd³ó¿ normalnej
        if strcmp(shA.type, 'sphere')
             shapeA = shA;
             shapeB= shB;
        else
             shapeA = shB;
             shapeB= shA;
        end
        
        out = false;
        k = 0;
        for i = 1:1:6
                if w_dot(shapeA.center, shapeB.planes(i,:)) < shapeA.r;
                        k = k+1;
                end
        end
        if k == 6
                out = true;
        end

end

function out = capsuleCapsule(shapeA, shapeB)
        out = false;
        if DistBetweenSegments(shapeA.p1, shapeA.p2, shapeB.p1, shapeB.p2) < shapeB.r+shapeA.r
                out = true;
        end
end

function out = capsuleBox(shA, shB)
        out = false;
        if strcmp(shA.type, 'capsule')
             shapeA = shA;
             shapeB= shB;
        else
             shapeA = shB;
             shapeB= shA;
        end
% kapsu³ê przyblizamy sferami
        a = shapeA.p1;
        b = shapeA.p2;
        
        sph = Sphere(a, shapeA.r);
        count = ceil(w_distance(a,b)/shapeA.r*2);
        
        vec = w_normalize(b - a)*w_distance(a,b)/count;
        
        for i = 1:1:count
                if sphereBox(sph, shapeB)
                        out = true;
                        return
                end
                 
                sph.center = sph.center + vec;
        end
        
        
        
        
end

function out = DistBetweenSegments(p1, p2, p3, p4)
        u = p1 - p2;
        v = p3 - p4;
        w = p2 - p4;
        
        a = w_dot(u,u);
        b = w_dot(u,v);
        c = w_dot(v,v);
        d = w_dot(u,w);
        e = w_dot(v,w);
        D = a*c - b*b;
        sD = D;
        tD = D;
        
        SMALL_NUM = 0.00000001;
        
        if (D < SMALL_NUM)  
                sN = 0.0;               
                sD = 1.0;               
                tN = e;
                tD = c;
        else                                
                sN = (b*e - c*d);
                tN = (a*e - b*d);
                if (sN < 0.0)           
                        sN = 0.0;
                        tN = e;
                        tD = c;
                elseif (sN > sD)
                        sN = sD;
                        tN = e + b;
                        tD = c;
                end
        end
        
        if (tN < 0.0)                       
                tN = 0.0;
                
                if (-d < 0.0)
                        sN = 0.0;
                elseif (-d > a)
                        sN = sD;
                else
                        sN = -d;
                        sD = a;
                end
        elseif (tN > tD)             
                tN = tD;
             
                if ((-d + b) < 0.0)
                        sN = 0;
                elseif ((-d + b) > a)
                        sN = sD;
                else 
                        sN = (-d + b);
                        sD = a;
                end
        end
        
     
        if(abs(sN) < SMALL_NUM)
                sc = 0.0;
        else
                sc = sN / sD;
        end
        
        if(abs(tN) < SMALL_NUM)
                tc = 0.0;
        else
                tc = tN / tD;
        end
        
        
        dP = w + (sc * u) - (tc * v);    

        out = norm(dP);
end

function out =  boxBox(shapeA, shapeB)
        
        % SAT, przypadek 3D
         T = shapeB.center - shapeA.center;
         %% sta³e
         Ax = shapeA.axis(1,:);
         Ay = shapeA.axis(2,:);
         Az = shapeA.axis(3,:);
         Bx = shapeB.axis(1,:); 
         By = shapeB.axis(2,:);
         Bz = shapeB.axis(3,:);
         Wa =    shapeA.dimensions(1)*0.5;
         Ha =    shapeA.dimensions(2)*0.5;
         Da =    shapeA.dimensions(3)*0.5;
         Wb = shapeB .dimensions(1)*0.5;
         Hb =    shapeB.dimensions(2)*0.5;
         Db =    shapeB.dimensions(3)*0.5;
        %% SAT
                 %%
                bool = zeros(15, 1);
                i = 1;
                % 1
                        L = Ax;
                        K = abs(w_dot(T,L));
                        bool(i) = K>Wa + abs(Wb*w_dot(L,Bx)) + abs(Hb*w_dot(L,By)) + abs(Db*w_dot(L, Bz));
                i = i+1;
                % 2
                        L = Ay;
                        K = abs(w_dot(T,L));
                        bool(i) = K>Ha + abs(Wb*w_dot(L,Bx)) + abs(Hb*w_dot(L,By)) + abs(Db*w_dot(L, Bz));
                i = i+1;
                % 3
                        L = Az;
                        K = abs(w_dot(T,L));
                        bool(i) = K>Da + abs(Wb*w_dot(L,Bx)) + abs(Hb*w_dot(L,By)) + abs(Db*w_dot(L, Bz));
                i = i+1;
                %% 
                % 4
                        L = Bx;
                        K = abs(w_dot(T,L));
                        bool(i) = K>Wb + abs(Wa*w_dot(L,Ax)) + abs(Ha*w_dot(L,Ay)) + abs(Da*w_dot(L, Az));
                i = i+1;
                % 5
                        L = By;
                        K = abs(w_dot(T,L));
                        bool(i) = K> Hb + abs(Wa*w_dot(L,Ax)) + abs(Ha*w_dot(L,Ay)) + abs(Da*w_dot(L, Az));
                i = i+1;
                % 6
                        L = Bz;
                        K = abs(w_dot(T,L));
                        bool(i) = K>    Db + abs(Wa*w_dot(L,Ax)) + abs(Ha*w_dot(L,Ay)) + abs(Da*w_dot(L, Az));
                i = i+1;
                %%
                %7
                        L = [w_cross(Ax, Bx) 0];
                        K = abs(w_dot(T,L));
                        bool(i) = K> abs(w_dot(Ha *Bx,Az)) + abs(w_dot(Da*Bx,Ay)) + abs(w_dot(Hb*Ax, Bz)) + abs(w_dot(Db*Ax,By));
                i = i+1;
                
                %8
                        L = [w_cross(Ax, By) 0];
                        K = abs(w_dot(T,L));
                        bool(i) = K> abs(w_dot(Ha *By,Az)) + abs(w_dot(Da*By,Ay)) + abs(w_dot(Wb*Ax, Bz)) + abs(w_dot(Db*Ax,Bx));
                i = i+1;
                
                %9
                        L = [w_cross(Ax, Bz) 0];
                        K = abs(w_dot(T,L));
                        bool(i) = K> abs(w_dot(Ha *Bz,Az)) + abs(w_dot(Da*Bz,Ay)) + abs(w_dot(Wb*Ax, By)) + abs(w_dot(Hb*Ax,Bx));
                i = i+1;
                
                %10
                        L    = [w_cross(Ay, Bx) 0];
                        K = abs(w_dot(T,L));
                        bool(i) = K> abs(w_dot(Wa *Az,Bx)) + abs(w_dot(Da*Ax,Bx)) + abs(w_dot(Hb*Ay, Bz)) + abs(w_dot(Db*Ay,By));
                i = i+1;
        
                %11
                        L = [w_cross(Ay, By) 0];
                        K = abs(w_dot(T,L));
                        bool(i) = K> abs(w_dot(Wa *Az,By)) + abs(w_dot(Da*Ax,By)) + abs(w_dot(Wb*Ay, Bz)) + abs(w_dot(Db*Ay,Bx));
                i = i+1;
                
                %12
                        L = [w_cross(Ay, Bz) 0];
                        K = abs(w_dot(T,L));
                        bool(i) = K> abs(w_dot(Wa *Az,Bz)) + abs(w_dot(Da*Ax,Bz)) + abs(w_dot(Wb*Ay, By)) + abs(w_dot(Hb*Ay,Bx));
                i = i+1;
                
                %13
                        L = [ w_cross(Az, Bx) 0];
                        K = abs(w_dot(T,L));
                        bool(i) = K> abs(w_dot(Wa *Ay,Bx)) + abs(w_dot(Ha*Ax,Bx)) + abs(w_dot(Hb*Az, Bz)) + abs(w_dot(Db*Az,By));
                i = i+1;
                
                %14
                        L = [w_cross(Az, By) 0];
                        K = abs(w_dot(T,L));
                        bool(i) = K> abs(w_dot(Wa *Ay,By)) + abs(w_dot(Ha*Ax,By)) + abs(w_dot(Wb*Az, Bz)) + abs(w_dot(Db*Az,Bx));
                i = i+1;
                
                %15
                        L = [ w_cross(Az, Bz) 0];
                        K = abs(w_dot(T,L));
                        bool(i) = K> abs(w_dot(Wa *Ay,Bz)) + abs(w_dot(Ha*Ax,Bz)) + abs(w_dot(Wb*Az, By)) + abs(w_dot(Hb*Az,Bx));
        %% analiza
                out = true;
                for i = 1:1:15
                        if bool(i) == true
                                out = false;
                                break;
                        end
                end
        
end

