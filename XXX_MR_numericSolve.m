function out = XXX_MR_numericSolve(aim, matrice,string)
    %% punkt docelowy, string zawiera coœ takiego 'd1, q2, q3'
    pa = matrice * [0 0 0 1]';
    
    y1 = aim(1) - pa(1);
    y2 = aim(2) - pa(2);
    y3 = aim(3) - pa(3);
    %%7
    out = solve(y1, y2, y3, string);
   
    a = vpa(out.d1);
    b = vpa(out.q2);
    c = vpa(out.q3);
    d = 0;
    
    %% wybór rzeczywistych rozwi¹zañ
    out = [];
    for i = 1:1:length(a)
        if isreal(a(i)) && isreal(b(i)) && isreal(c(i)) 
            out = [out; a(i) b(i) c(i) d]; 
        end
    end
    
    out = single(out);
    
    if length(out)>0
        fprintf('\nZnaleziono [ %d ] rozwiazan.\n', length(out(:,1)));
    else 
        fprintf('\nBrak rozwiazan.\n');
        out = [0 0 0 0];
    end
end