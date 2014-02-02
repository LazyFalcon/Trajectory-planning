function robot = genEmptyRobot()
  robot.max = [];
  robot.min = [];
  robot.max_v = [];
  robot.max_a = [];
  robot.zmie = [];
  robot.bindGP = [];
  robot.initialPosition = [0 0 0 1];
  robot.jointWeight = [];
  
   robot.parts = 0;
  
   robot.mat = {};
   robot.part = [];
   robot.efector = 0;
   robot.efector_radius = 40;
   robot.shape = {};
   robot.shapeDelay = {};
end