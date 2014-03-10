function out = substitution(val,  module)
  val;
  zmie = module.zmie;
  z = module.zmie*val + module.val;
  v = module.val;
  

    out = [ cos(z(1)), -cos(z(4))*sin(z(1)),  sin(z(1))*sin(z(4)), z(3)*cos(z(1));
                  sin(z(1)),  cos(z(1))*cos(z(4)), -cos(z(1))*sin(z(4)), z(3)*sin(z(1));
                  0,          sin(z(4)),          cos(z(4)),         z(2);
                  0,                0,                0,          1];
 

end
