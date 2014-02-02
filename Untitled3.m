
                        bez = [
                            0 1 0 1; 
                            1 1 0 4.8; 
                            0 2 0 0.2;
                            1 2 0 1
                            ];
                    bez2 = [
                            1 2 0 1; 
                            0 2 0 0.8; 
                            1 1 0 5.2;
                            0 1.5 0 1
                            ];
                        t = 0:0.01:1;
                        points = bezier4(bez, t, 3);
                        points2 = bezier4(bez2, t, 3);
                        y = [points(:,2); points2(2:end,2)];
                        x = 0:0.01:2;
%                         drawPath3d(points,'k')
plot(x,y,'k')