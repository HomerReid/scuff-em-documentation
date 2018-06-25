//
// Hemispherical shell used to visualize radiation pattern
// for edge-fed patch antenna
// 
// homer reid 20180507 
//

//************************************************************
//* input parameters      
//************************************************************
DefineConstant[ R = 24.0 ];  // hemisphere radius

X0 = 3.112;     // X,Y coordinates of patch center
Y0 = 12.0;

//************************************************************
//************************************************************
//************************************************************
Point(1) = {  X0,    Y0,   0};
Point(2) = {  X0,    Y0-R, 0};
Point(3) = {  X0+R,  Y0,   0};
Point(4) = {  X0,    Y0+R, 0};
Point(5) = {  X0-R,  Y0,   0};

Circle(1) = { 2, 1, 3 };
Circle(2) = { 3, 1, 4 };

Circle(3) = { 4, 1, 5 };
Circle(4) = { 5, 1, 2 };

Extrude { {0,1,0}, {X0, Y0, 0},  Pi/2} { Line{1,2}; }
Extrude { {0,1,0}, {X0, Y0, 0}, -Pi/2} { Line{1,2}; }
Extrude { {0,1,0}, {X0, Y0, 0},  Pi/2} { Line{3,4}; }
Extrude { {0,1,0}, {X0, Y0, 0}, -Pi/2} { Line{3,4}; }

Physical Surface(2) = { 13, 16, 19, 22 };   // upper hemisphere
