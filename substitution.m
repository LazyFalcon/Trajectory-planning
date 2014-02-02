function out = substitution(val,  module)
  val;
  zmie = module.zmie;
  z = module.zmie;
  v = module.val;
  
   out = [ cos(v(4) + val*z(4)), -sin(v(4) + val*z(4))*cos(v(1) + val*z(1)),  sin(v(4) + val*z(4))*sin(v(1) + val*z(1)), (v(2)+val*z(2))*cos(v(4) + val*z(4));
 sin(v(4) + val*z(4)),  cos(v(4) + val*z(4))*cos(v(1) + val*z(1)), -cos(v(4) + val*z(4))*sin(v(1) + val*z(1)),  (v(2)+val*z(2))*sin(v(4) + val*z(4));
          0,             sin(v(1) + val*z(1)),             cos(v(1) + val*z(1)),             (v(3)+val*z(3));
          0,                      0,                      0,            1];
 
end
