DefineConstant[ LX = 12 ];
DefineConstant[ LY = 5 ];

DefineConstant[ X0 = 1.3  ];
DefineConstant[ Y0 = +0.8 ];

Point(1) = { 0,  0, 0 };
Point(2) = { LX, 0, 0 };

Line(1) = {1,2};

Extrude{ {0,0,1}, {0,0,0}, Pi/3 } { Line{1}; }
Extrude{ {0,0,1}, {0,0,0}, Pi/3 } { Line{2}; }
Extrude{ {0,0,1}, {0,0,0}, Pi/3 } { Line{5}; }
Extrude{ {0,0,1}, {0,0,0}, Pi/3 } { Line{8}; }
Extrude{ {0,0,1}, {0,0,0}, Pi/3 } { Line{11}; }
Extrude{ {0,0,1}, {0,0,0}, Pi/3 } { Line{14}; }
