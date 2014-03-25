function Mn=change(M,lp)  
l=char(M); 
h  = strrep(l,'*','.*');
h1 = strrep(h,'^','.^');
h2 = strrep(h1,'/','./');

for i=1:lp
    qzt=strcat('q',num2str(i));
    vzt=strcat('vz',num2str(i));
    azt=strcat('az',num2str(i));
    xtt=strcat('xt',num2str(i));
    vtt=strcat('vt',num2str(i));
    att=strcat('at',num2str(i));
       
    h3 = strrep(h2,qzt,xtt);
    h4 = strrep(h3,vzt,vtt);
    h2 = strrep(h4,azt,att);

end

Mn=h2;

end
