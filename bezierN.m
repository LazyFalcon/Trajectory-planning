function out=bezierN(bez,t)
% bezier trzeciego stopnia, przez 4 punkty
% t=0:1
% bez:macierz 4 punktów, u³orzone wierszowo  
        len = length(t);
        out = zeros(len,length(bez(1,:)));
        N = length(bez(:,1));
        n = N - 1;
        
        for i = 1:1:len
            point = zeros(size(bez(1,:)));
            sums = 0;
            for j = 1:1:N
                tmp = bez(j,end)*(w_b(t(i),n,j-1));
                sums = sums + tmp;
                point = point + tmp * bez(j,:);
            end    
            out(i,:) = point/sums;
        end

        
end