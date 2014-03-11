function robot = addCollShape(robot, shape, delay)
	% dodaje do struktury robota nowy kszta³t otaczaj¹cy cz³on
	% Description
% .........................................................................
% Autor:                    Karol Wajs
% Date updating:            23.01.2014 r
%
% .........................................................................
% 
% 
% 
% 
%
% Input data:
% robot
% shape
% delay - vector wyra¿ony w LUW cz³onu
% 
% 
% 
% Output data:
% robot
% 
% .........................................................................

%%
	
	if nargin < 3
		delay = [0 0 0 0];
	end
	robot.shapeDelay{end+1} = delay;
	robot.shape{end+1} = shape;
end