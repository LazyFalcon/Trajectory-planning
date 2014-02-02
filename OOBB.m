function box = OOBB(pa, pb, rot, Ylen, Zlen, axes)
    % punkt pocz¹tkowy, koñcowy, rotacja, wymiary po Y, po Z
    Xlen = w_distance(pa, pb);
    if nargin == 5
        axes = [
        1 0 0 0;
        0 1 0 0;
        0 0 1 0
        ];
    end
    
    
    %% macierz rotacji woków wektora
        norm = w_normalize(pb - pa);
        x = norm(1);
        y = norm(2);
        z = norm(3);
            rot = rot*pi/180; % zamiana na radiany
        c = cos(rot);
        s= sin(rot);
        rotation  =  [
            x*x*(1-c)+c x*y*(1-c)-z*s x*z*(1-c)+y*s 0;
            y*x*(1-c)+z*s y*y*(1-c)+c y*z*(1-c)-x*s 0;
            x*z*(1-c)-y*s y*z*(1-c)+x*s z*z*(1-c)+c 0;
            0 0 0 1;
        ];
    %% osie boxa
        X = w_normalize(pb - pa);
        if isequal(abs(X), [0 1 0 0])
            Z = [w_normalize(w_cross(X, axes(1,:))) 0];
        else
            Z = [w_normalize(w_cross(X, axes(2,:))) 0];
        end
        Y = [w_normalize(w_cross(X, Z)) 0];

        Z = w_normalize(rotation*Z')';
        Y = w_normalize(rotation*Y')';
    
    %% p³aszczyzny boxa, u³ozone s¹ w ten sposób ¿e napierw id¹ te których normalna jest X, Y i Z
        planes = zeros(6,4);
        planes(1,:) = plane(X, pa);
        planes(2,:) = plane(X, pb);
        
        ca = pa -0.5 * Ylen*Y;
        planes(3,:) = plane(Y, ca);
        
        ca = pa +0.5 * Ylen*Y;
        planes(4,:) = plane(Y, ca);
        
        ca = pa -0.5 * Zlen*Z;
        planes(5,:) = plane(Z, ca);
        
        ca = pa +0.5 * Zlen*Z;
        planes(6,:) = plane(Z, ca);
        
        center = (pa + pb)/2;
        % u³orzenie p³aszczyzn tak, by by³y skierowane normalnymi na
        % zewnatrz
        for i =1:1:6
            if w_dot(center, planes(i,:)) > 0
                planes(i,:) = -1 * planes(i,:);
            end
        end
    %% sk³adanie boxa
        box.center = center;
        box.planes = planes;
        box.axis = [X;Y;Z];
        box.dimensions = [Xlen, Ylen,Zlen];
        box.rot = rot;
        box.type = 'box';
        
        %wyznaczenie sfery otaczaj¹cej
        box.sph_r = w_distance(center, center+(X*Xlen+Y*Ylen + Z*Zlen)/2)*1.3;
        

    
end

function out = plane(norm, point)
    out = [norm(1:3) -w_dot(norm(1:3), point(1:3))];
end