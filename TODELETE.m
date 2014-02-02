% bezier opisujacy charakterystykê regulacji silnika? 
bezier = [
 0 0.3 1;
 1 1.25 4;
 0 -0.5 0.4;
 1 -0.5 1
 ];

t = 0:0.01:1;
resp = bezier4(bezier, t, 3);
plot(t, resp(:,2))

