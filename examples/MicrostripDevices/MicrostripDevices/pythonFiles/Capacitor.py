##############################################################
# python code for analyzing a microstrip patch antenna in scuff-em
# Homer Reid 20180422
###############################################################
from __future__ import print_function;
import argparse

scuffExample="MicrostripDevices"
execfile('setupSCUFF.py')

os.environ["OMP_NUM_THREADS"] = "8"
os.environ["GOMP_CPU_AFFINITY"] = "0-7"
os.environ["SCUFF_MESH_PATH"] = "/home/homer/work/scuff-em-development/examples/MicrostripDevices/mshFiles"
os.environ["SCUFF_DATA_PATH"] = "/home/homer/work/scuff-em-development/examples/MicrostripDevices/portFiles"
os.environ["SCUFF_GEO_PATH"] = "/home/homer/work/scuff-em-development/examples/MicrostripDevices/scuffgeoFiles"

parser = argparse.ArgumentParser()
parser.add_argument('--res', type=str,   default=280,  help='resolution (280,1160,2640)')
parser.add_argument('--eps', type=float, default=10.0, help='epsilon')
parser.add_argument('--h',   type=float, default=1.0,  help='h')
args = parser.parse_args()

Res = args.res
EpsSubstrate = args.eps
hSubstrate   = args.h

###################################################
# create the solver, add metal traces, define ports,
# initialize substrate
###################################################
Solver=scuff.scuffSolver()

Solver.AddMetalTraceMesh("Plate10x10_" + Res + ".msh");

Solver.AddPort([-1, 0, 0, 1, 0, 0])

Solver.SetSubstratePermittivity(EpsSubstrate)
Solver.SetSubstrateThickness(hSubstrate)

#Solver.AssembleSystemMatrix(1.0)
#Solver.Solve(0,1.0)
#II=Solver.PlotRFFields()

###################################################
# open output files, write file preamble
###################################################
ZParmFile = open("N" + Res + ".zparms",'a')
ZParmFile.write("\n\n");
ZParmFile.write("# Data columns:\n");
ZParmFile.write("# 1   frequency (GHz)\n");
ZParmFile.write("# 2   h (substrate thickness)\n");
ZParmFile.write("# 3   Eps (substrate permittivity)\n");
ZParmFile.write("# 4,5 re,im Z11 (Ohms)\n");

Freqs = np.logspace(-1,1,20) # frequencies at which to calculate (GHz)
for Freq in Freqs:

        print("F={:.1f} GHz: ".format(Freq),end='')
	Solver.AssembleSystemMatrix(Freq)        # assemble SIE system
        ZMatrix = Solver.GetFullZMatrix();           # compute Z matrix
        ZParmFile.write("%e %e %e " % (Freq,EpsSubstrate,hSubstrate))
        NumPorts=ZMatrix.NC
        for DestPort in range(0,NumPorts):
            for SourcePort in range(0,NumPorts):
                for nTerm in range(0,4):
                    Z = ZMatrix.GetEntry(4*DestPort + nTerm, SourcePort)
                    ZParmFile.write("%e %e " % (Z.real, Z.imag))
        ZParmFile.write("\n")
        ZParmFile.flush()

ZParmFile.close()
