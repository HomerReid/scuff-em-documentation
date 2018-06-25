REF='/home/homer/work/scuff-em-sandbox/MicrostripDevices_20180507/Run8/L8_NFine.Zparms'
DATA='EFAntenna_L8_Coarse.Zparms'

i={0,1}
S11(x)=log(abs( ($2+i*$3-50)/($2+i*$3+50) ))
S11S(x)=log(abs( ($2-i*$3-50)/($2-i*$3+50) ))

plot  REF  u 1:(S11($1)) w lp pt 7 ps 1      \
  ,  DATA u 1:(S11($1)) w lp pt 6 ps 1.5     
