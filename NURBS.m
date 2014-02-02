function out = NURBS(points)
% p=(i,4)
% na wyjœciu wygenerowan¹ trasê
% stopnia
    %% DEBUG draw points
%      for i = 1:1:length(points)
%          hold on
%          drawPoint3d(points(i,:), 'ko');
%      end
%%
    n = 3;
    len = length(points(:,1));
    m = len-n;
    f = zeros(m,4);
    g = zeros(m,4);
    e = zeros(m+1,4);
    
    f(1,:) = points(2,:);
    g(1,:) = (points(2,:)+points(3,:))/2;
    
    for i = 2:m-1
       f(i,:) = (2*points(i+1,:) +points(i+2,:))/3;
       g(i,:) = (points(i+1,:) +2*points(i+2,:))/3;
    end
   
    f(m,:) = (points(m+3,:)+points(m+2,:))/2;
    g(m,:) = points(m+2,:);
    
    
    e(1,:) = points(1,:);
    for i = 2:1:m
        e(i,:) = (g(i-1,:)+f(i,:))/2;
    end
    e(m+1,:) = points(m+3,:);
    
    for i = 1:1:m
       beziers{i} = [e(i,:); f(i,:); g(i,:); e(i+1,:)];
%        DEBUG draw control points of bezier curves
%        drawPoint3d(e(i,:),'ks');
%        drawPoint3d(e(i,:),'k.');
%        text(e(i,1), e(i,2), e(i,3),['   {e}_{' num2str(i-1) '}'],'HorizontalAlignment','left','FontSize',13);
%        hold on
%        drawPoint3d(f(i,:),'ks');
%        drawPoint3d(f(i,:),'k.');
%        text(f(i,1), f(i,2), f(i,3),['   {f}_{' num2str(i-1) '}'],'HorizontalAlignment','left','FontSize',13);
%        drawPoint3d(g(i,:),'ks');
%        drawPoint3d(g(i,:),'k.');
%        text(g(i,1), g(i,2), g(i,3),['   {g}_{' num2str(i-1) '}'],'HorizontalAlignment','left','FontSize',13);
% drawLine3d(f(i+1,:), g(i,:), 'k',1)
%        hold off
% drawPath3d(points, 'k--', 1)
    end
%     for i =1 :1:length(points)
%       drawPoint3d(points(i,:),'ko');
%       drawPoint3d(points(i,:),'k.');
%        text(points(i,1), points(i,2), points(i,3),['   {p}_{' num2str(i-1) '}'],'HorizontalAlignment','left','FontSize',13);
%     end
%        drawPoint3d(e(end,:),'ks');
%        drawPoint3d(e(end,:),'k.');
%        text(e(end,1), e(end,2), e(end,3),['   {e}_{' num2str(length(e)-1) '}'],'HorizontalAlignment','left','FontSize',13);
       
       
    %% generate spline
    spline = [];
    t = 0:0.01:1;
    for i = 1:1:length(beziers)
        spline = [spline; bezier4(beziers{i}, t, 3)];
    end
    
    out = Interpolate(spline);
    
end



