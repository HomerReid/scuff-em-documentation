DefineConstant [ W     = 15     ];
DefineConstant [ L     = 30     ];
DefineConstant [ H     = 3      ]; 

Point(101) = {-0.5*W, -5, 0.0};
Point(102) = { 0.5*W, -5, 0.0};
Line(101)  = {101,102};
Extrude { 0, L,  0  }     { Line{101}; }
Extrude { 0, 0, -H  }     { Surface{105}; }
Extrude { 0, 0, -0.1*H  } { Surface{127}; }

Physical Volume(1)={1};
Physical Volume(2)={2};
