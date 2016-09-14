RReg(x)    = -cos(x)/x + sin(x)/(x*x)
RBarReg(x) = cos(x)/(x*x) + (x*x-1)*sin(x)/(x*x*x);

II={0.0,1.0}

ROut(x)    = -II*(1-II*x)*exp(II*x)/(x*x);
RBarOut(x) =  II*(1-II*x+x*x)*exp(II*x)/(x*x*x);

CFull(a,n,Z)=                                          \
( RReg(a)*RBarReg(n*a)   - Z*RBarReg(a)*RReg(n*a)  ) /    \
( Z*RReg(n*a)*RBarOut(a) -   RBarReg(n*a)*ROut(a)  )

DFull(a,n,Z)=                                          \
( RBarReg(a)*RReg(n*a)   - Z*RReg(a)*RBarReg(n*a)  ) /    \
( Z*RBarReg(n*a)*ROut(a) -   RReg(n*a)*RBarOut(a)  )

CIBC(a,Eta)=RReg(a) / ( II*Eta*RBarOut(a) - ROut(a) )
DIBC(a,Eta)=RBarReg(a) / ( II*Eta*ROut(a) + RBarOut(a) )

wp = 1.37e16;
gamma = 5.32e13;
w0 = 3.0e14;
EpsGold(w) = 1.0 - (wp*wp) / (w*w0 * (w*w0 + II*gamma));

n(w) = sqrt(EpsGold(w))
Z(w) = 1/sqrt(EpsGold(w))

HABS(x)=(ABS ? abs(x) : x)

set xrange [0.01:10]
set terminal qt 1
R=1
plot HABS(real(CFull(x*R,n(x),Z(x))))  w lp pt 7 ps 1 lc RED \
    ,HABS(imag(CFull(x*R,n(x),Z(x))))  w lp pt 7 ps 1 lc BLUE\
    ,HABS(real(CIBC(x*R,Z(x))))        w lp pt 6 ps 2 lt 0 lc RED\
    ,HABS(imag(CIBC(x*R,Z(x))))        w lp pt 6 ps 2 lt 0 lc BLUE

set xrange [0.01:10]
set terminal qt 2
plot HABS(real(CFull(x*R,n(x),Z(x))))  w lp pt 7 ps 1 lc RED \
    ,HABS(imag(CFull(x*R,n(x),Z(x))))  w lp pt 7 ps 1 lc BLUE\
    ,HABS(real(CIBC(x*R,Z(x))))        w lp pt 6 ps 2 lt 0 lc RED\
    ,HABS(imag(CIBC(x*R,Z(x))))        w lp pt 6 ps 2 lt 0 lc BLUE
