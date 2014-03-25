function out = XXX_MR_pathIK(points, matrix, string)
    % matrix, macierz transforamcji T03
    out = {};
    out{1} = [];
    out{2} = [];
   for i = 1:1:length(points(:,1))
       tmp = XXX_MR_numericSolve(points(i,:), matrix, string);
       for k = 1:1:length(tmp(:,1))
            out{k} = [out{k}; tmp(k,:)];
       end
   end
end