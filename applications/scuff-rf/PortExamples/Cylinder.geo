R=1.0;   // disc radius
T=5.0;   // disc thickness
C=1.0;   // sidewall curvature minor axis (=0 for flat side walls)

N = 3;   // panels per unit length

NPhi = Ceil[N*Pi*R/2];
NZ   = Ceil[N*T];

Point(100) = { 0,   0,    0};
Point(101) = { R,   0,    0};

Out[]=Extrude { {0,0,1}, {0,0,0}, Pi/2 } { Point{101}; Layers{NPhi}; };
Lines[]=Out[1];

Out[]=Extrude { {0,0,1}, {0,0,0}, Pi/2 } { Point{Out[0]}; Layers{NPhi}; };
Lines[] += Out[1];

Out[]=Extrude { {0,0,1}, {0,0,0}, Pi/2 } { Point{Out[0]}; Layers{NPhi}; };
Lines[] += Out[1];

Out[]=Extrude { {0,0,1}, {0,0,0}, Pi/2 } { Point{Out[0]}; Layers{NPhi}; };
Lines[] += Out[1];

Out[]=Extrude { 0, 0, T } { Line{Lines[]}; Layers{NZ}; };
