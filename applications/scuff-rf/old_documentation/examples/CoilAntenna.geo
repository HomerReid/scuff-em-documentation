// 
// GMSH geometry file for a loop antenna with four gaps for 
// driving ports 
// 
// homer reid 3/2011
//

// 
// tweakable geometric parameters (all specified in units of mm)
// 
ROut  = 75.0;     // outer radius
RIn   = 70.0;     // inner radius
G     =  1.0;     // gap width   

lFine   =   5.0;     // meshing lengthscale near gaps
lCoarse =  25.0;     // meshing lengthscale away from gaps

//////////////////////////////////////////////////
// a single quadrant of the loop                    
//////////////////////////////////////////////////
Point(000) = {               0,                0, 0, lFine };
Point(100) = {             RIn,              G/2, 0, lFine };
Point(101) = {            ROut,              G/2, 0, lFine };
Point(102) = {  ROut*Cos(Pi/4),   ROut*Sin(Pi/4), 0, lCoarse };
Point(103) = {             G/2,             ROut, 0, lFine   };
Point(104) = {             G/2,              RIn, 0, lFine   };
Point(105) = {   RIn*Cos(Pi/4),    RIn*Sin(Pi/4), 0, lCoarse };

Line(100) = { 100, 101 };
Circle(101) = { 101, 000, 102 }; 
Circle(102) = { 102, 000, 103 }; 
Line(103) = { 103, 104 };
Circle(104) = { 104, 000, 105 }; 
Circle(105) = { 105, 000, 100 }; 

Line Loop(1)     = {100, 101, 102, 103, 104, 105};
Plane Surface(1) = {1};

//////////////////////////////////////////////////
// the other three quadrants are obtained by duplicating 
// and rotating the first quadrant                         
//////////////////////////////////////////////////
Rotate{ {0,0,1}, {0,0,0}, 1*Pi/2 } { Duplicata{ Surface{1}; } }
Rotate{ {0,0,1}, {0,0,0}, 2*Pi/2 } { Duplicata{ Surface{1}; } }
Rotate{ {0,0,1}, {0,0,0}, 3*Pi/2 } { Duplicata{ Surface{1}; } }

//////////////////////////////////////////////////
//////////////////////////////////////////////////
Physical Surface(1)={1, 106, 113, 120};
