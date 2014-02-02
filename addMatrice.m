function robot = addMatrice(robot, Rx, Tx, Tz, Rz, zmie)

  robot.max(end+1) =  1000;
  robot.min(end+1) = -1000;
  robot.max_v(end+1) = 1000;
  robot.max_a(end+1) = 1000;
  robot.bindGP(end+1) = 0;
  robot.zmie =  [robot.zmie; zmie];
  if w_dot([1 1 1 1], zmie) == 1
    robot.jointWeight = [robot.jointWeight; 1];
  end
 
   robot.part(end+1).module.val = [Rx Tx Tz Rz];
   robot.part(end).module.zmie = zmie;
   
   robot.parts = length(robot.mat);
   
   
end