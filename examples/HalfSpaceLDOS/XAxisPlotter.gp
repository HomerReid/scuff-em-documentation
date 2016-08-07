FILE1='Run5/PECPlate_L0P1_176.byOmegakBloch'
FILE2='Run5/PECPlate_L0P1_40.byOmegakBloch'
FILE3='Run6/AlHalfSpace_L0P01_176.byOmegakBloch'
FILE4='Run6/AlHalfSpace_L0P01_40.byOmegakBloch'
FILE5='Run6/AlHalfSpace_L0P1_176.byOmegakBloch'
FILE6='Run6/AlHalfSpace_L0P1_40.byOmegakBloch'
FILE7='Run6/E10HalfSpace_L0P01_176.byOmegakBloch'
FILE8='Run6/E10HalfSpace_L0P01_40.byOmegakBloch'
FILE9='Run6/E10HalfSpace_L0P1_176.byOmegakBloch'
FILE10='Run6/E10HalfSpace_L0P1_40.byOmegakBloch'

REF='Run7/AlHalfSpace_L0P1_40.aluminum.byOmegakBloch'

KX(Z)=(ifeq($3,Z,$6))

#set terminal x11 1
#set xrange [0:32]
#set yrange [-100:100]
#unset logscale xy
#set xlabel '$k_x$'
#set ylabel '$\rho^{\text{E}}(\mathbf{k})$'
#plot FILE6 u (KX(Z)):8 t '' w lp pt 7 ps 1
#call 'latex' 'RhoEVskX'

set terminal x11 2
set logscale y
set xlabel '$|\mathbf{k}_\text{B}|$'
set ylabel '$\rho^{\text{E}}(\mathbf{k}_\text{B})$'
set key at 4,0.1 spacing 5
unset logscale x
set xrange [0:10]
set yrange [1e-5:]
unset xtics
set xtics add ("9"      0)
set xtics add (""        1)
set xtics add ("9.99"   2)
set xtics add (""        3)
set xtics add ("9.9999" 4)
set xtics add (""        5)
set xtics add ("10.0001" 6)
set xtics add (""        7)
set xtics add ("10.01"  8)
set xtics add (""        9)
set xtics add ("11"    10)
call 'vline' 5
plot FILE6 u (iflt(KX(1),10,1-log10(10-KX(1)))):(abs($8)) t '$z=1000 $nm' w lp pt 7 ps 1 lc 1   \
   , FILE6 u (ifgt(KX(1),10,9+log10(KX(1)-10))):(abs($8)) t '' w lp pt 7 ps 1 lc 1   \
   , FILE6 u (iflt(KX(0.1),10,1-log10(10-KX(0.1)))):(abs($8)) t '$z=100 $nm' w lp pt 7 ps 1 lc 2 \
   , FILE6 u (ifgt(KX(0.1),10,9+log10(KX(0.1)-10))):(abs($8)) t '' w lp pt 7 ps 1 lc 2 \
   , FILE6 u (iflt(KX(0.01),10,1-log10(10-KX(0.01)))):(abs($8)) t '$z=10 $nm' w lp pt 7 ps 1 lc 3 \
   , FILE6 u (ifgt(KX(0.01),10,9+log10(KX(0.01)-10))):(abs($8)) t '' w lp pt 7 ps 1 lc 3
call 'latex' 'RhoEVskXLogScale'
