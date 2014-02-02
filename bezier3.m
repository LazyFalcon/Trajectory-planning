function out = bezier3(points,t,n)
% bezier drugiego stopnia, przez 3 punkty
% t=0:1
% bez: krzywe beziera, u³orzone wierszami(3 punkty i ) 
        len = length(t);
        out = zeros(len,4);
        for i = 1:1:len
            k = 1 * w_b(t(i), n, 0);
            l = points(2,4) * w_b(t(i),n,1);
            m = 1 * w_b(t(i),n,2);

            
            out(i,:) = (k*points(1,:)+l*points(2,:)+m*points(3,:))/(k+l+m);
            out(i,4) = 1;
        end

        
end