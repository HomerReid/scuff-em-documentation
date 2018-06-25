###############################################################
# scuff-python code for analyzing coupled microstrip patch antennas
# Homer Reid 20180422
###############################################################
from __future__ import print_function;

scuffExample="MicrostripDevices"
execfile('setupSCUFF.py')

# set meshing resolution ("Coarse" or "Fine")
Res  = "Coarse"

Freq   = 1.41          # frequency in GHz
Lambda = 300.0/Freq    # wavelength = 300 mm / (f in GHz)

# dimensions of patch
LX = 105.7
LY = 65.5

###################################################
# create the solver, add metal traces, define ports,
# initialize substrate
###################################################
Solver=scuff.RFSolver()

# add first patch and define a port terminal on it
MeshFile = "PFAntenna_" + Res + ".msh"
Solver.AddMetalTraceMesh(MeshFile, "Patch1");
Solver.AddPort([0, 0, 0]);

# add second patch at displaced site and define a port terminal on it
Solver.AddMetalTraceMesh(MeshFile,"Patch2","DISPLACED " + str(LX) + " " + str(LY) + " 0");
Solver.AddPort([LX, LY, 0]);

Solver.SetSubstratePermittivity(2.5)
Solver.SetSubstrateThickness(1.575)

Solver.PlotGeometry()

# Since we will be recomputing the system matrix at the same frequency
# for many different relative displacments of the patches, we definitely
# want to enable block caching
Solver.EnableSystemBlockCache();

###################################################
# open output files, write file preamble
###################################################
ZParmFile = open("PFAntennas_" + Res + ".Zparms", 'w')
ZParmFile.write("# Data columns:\n");
ZParmFile.write("#  1    frequency (GHz)\n");
ZParmFile.write("#  2, 3 DeltaX, DeltaY (patch-patch separation)");
ZParmFile.write("#  4, 5 abs, arg Z11    \n");
ZParmFile.write("#  6, 7 abs, arg Z12    \n");
ZParmFile.write("#  8, 9 abs, arg Z21    \n");
ZParmFile.write("#  8, 9 abs, arg Z22    \n");

SParmFile = open("PFAntennas_" + Res + ".Sparms", 'w')
SParmFile.write("# Data columns:\n");
SParmFile.write("#  1    frequency (GHz)\n");
SParmFile.write("#  2, 3 DeltaX, DeltaY (patch-patch separation)");
SParmFile.write("#  4, 5 abs, arg S11    \n");
SParmFile.write("#  6, 7 abs, arg S12    \n");
SParmFile.write("#  8, 9 abs, arg S21    \n");
SParmFile.write("# 10,11 abs, arg S22    \n");

###################################################
# compute S-parameters over a range of displacements in the X direction
###################################################
for DeltaX in np.arange(0.1,1.75,0.05):

    print("DeltaX={:.1f}: ".format(DeltaX),end='')
    DX=Lambda*DeltaX
    Solver.Transform("Patch2","DISPLACED " + str(DX) + " " + str(-LY) + " 0");
    Solver.PlotGeometry("/tmp/DeltaX" + str(DeltaX) + ".pp")

    t0  = time.time()
    Solver.AssembleSystemMatrix(Freq)        # assemble SIE system
    t1  = time.time()
    print(" system {:.1f}s: ".format(t1-t0),end='')

    ZMatrix = Solver.GetZMatrix();           # compute Z matrix
    SMatrix = Solver.Z2S(ZMatrix);           # convert to S matrix
    t2  = time.time()
    print(" zmatrix {:.1f}s: ".format(t2-t1))

    ZParmFile.write("%e %e %e " %(Freq,DeltaX,0))
    Z=ZMatrix.GetEntry(0,0); ZParmFile.write("%e %e " %(abs(Z),np.angle(Z)))
    Z=ZMatrix.GetEntry(0,1); ZParmFile.write("%e %e " %(abs(Z),np.angle(Z)))
    Z=ZMatrix.GetEntry(1,0); ZParmFile.write("%e %e " %(abs(Z),np.angle(Z)))
    Z=ZMatrix.GetEntry(1,1); ZParmFile.write("%e %e " %(abs(Z),np.angle(Z)))
    ZParmFile.write("\n")
    ZParmFile.flush()

    SParmFile.write("%e %e %e " %(Freq,DeltaX,0))
    S=SMatrix.GetEntry(0,0); SParmFile.write("%e %e " %(abs(S),np.angle(S)))
    S=SMatrix.GetEntry(0,1); SParmFile.write("%e %e " %(abs(S),np.angle(S)))
    S=SMatrix.GetEntry(1,0); SParmFile.write("%e %e " %(abs(S),np.angle(S)))
    S=SMatrix.GetEntry(1,1); SParmFile.write("%e %e " %(abs(S),np.angle(S)))
    SParmFile.write("\n")
    SParmFile.flush()

    Solver.UnTransform()

ZParmFile.write("\n\n");
SParmFile.write("\n\n");

###################################################
# compute S-parameters over a range of displacements in the Y direction
###################################################
for DeltaY in np.arange(0.1,1.75,0.05):

    print("DeltaY={:.1f}: ".format(DeltaY),end='')
    DY=Lambda*DeltaY
    Solver.Transform("Patch2","DISPLACED " + str(-LX) + " " + str(DY) + " 0");
    Solver.PlotGeometry("/tmp/DeltaY" + str(DeltaY) + ".pp")

    t0  = time.time()
    Solver.AssembleSystemMatrix(Freq)        # assemble SIE system
    t1  = time.time()
    print(" system {:.1f}s: ".format(t1-t0),end='')

    ZMatrix = Solver.GetZMatrix();           # compute Z matrix
    SMatrix = Solver.Z2S(ZMatrix);           # convert to S matrix
    t2  = time.time()
    print(" zmatrix {:.1f}s: ".format(t2-t1))

    ZParmFile.write("%e %e %e " %(Freq,0,DeltaY))
    Z=ZMatrix.GetEntry(0,0); ZParmFile.write("%e %e " %(abs(Z),np.angle(Z)))
    Z=ZMatrix.GetEntry(0,1); ZParmFile.write("%e %e " %(abs(Z),np.angle(Z)))
    Z=ZMatrix.GetEntry(1,0); ZParmFile.write("%e %e " %(abs(Z),np.angle(Z)))
    Z=ZMatrix.GetEntry(1,1); ZParmFile.write("%e %e " %(abs(Z),np.angle(Z)))
    ZParmFile.write("\n")
    ZParmFile.flush()

    SParmFile.write("%e %e %e " %(Freq,0,DeltaY))
    S=SMatrix.GetEntry(0,0); SParmFile.write("%e %e " %(abs(S),np.angle(S)))
    S=SMatrix.GetEntry(0,1); SParmFile.write("%e %e " %(abs(S),np.angle(S)))
    S=SMatrix.GetEntry(1,0); SParmFile.write("%e %e " %(abs(S),np.angle(S)))
    S=SMatrix.GetEntry(1,1); SParmFile.write("%e %e " %(abs(S),np.angle(S)))
    SParmFile.write("\n")
    SParmFile.flush()

    Solver.UnTransform()

ZParmFile.close()
SParmFile.close()
