function out=w_normalize(vec)
% normalizacja wektora
    len = sqrt(sum(vec.^2));
    if len == 0
        out = vec* 0;
    else
      out = vec/len;
    end
   out;
end