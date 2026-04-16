v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -190 -180 -40 -180 {lab=#net1}
N -40 -180 80 -180 {lab=#net1}
N 80 -180 240 -180 {lab=#net1}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_nfet.sym} -10 -40 0 1 {name=nfet1 model=asap_7nm_nfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_pfet.sym} -20 -150 0 1 {name=pfet1 model=asap_7nm_pfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_pfet.sym} 60 -150 0 0 {name=pfet2 model=asap_7nm_pfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_pfet.sym} 220 -150 0 0 {name=pfet3 model=asap_7nm_pfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_pfet.sym} -170 -150 0 1 {name=pfet4 model=asap_7nm_pfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_pfet.sym} -210 -60 0 0 {name=pfet5 model=asap_7nm_pfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_pfet.sym} -290 -60 0 1 {name=pfet6 model=asap_7nm_pfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_nfet.sym} 70 -40 0 0 {name=nfet2 model=asap_7nm_nfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_nfet.sym} -310 50 0 0 {name=nfet3 model=asap_7nm_nfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_nfet.sym} -310 140 0 0 {name=nfet4 model=asap_7nm_nfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_nfet.sym} -70 70 0 0 {name=nfet5 model=asap_7nm_nfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_nfet.sym} 240 210 0 1 {name=nfet6 model=asap_7nm_nfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_nfet.sym} 330 210 0 0 {name=nfet7 model=asap_7nm_nfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_nfet.sym} 580 210 0 1 {name=nfet8 model=asap_7nm_nfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_nfet.sym} 670 210 0 0 {name=nfet9 model=asap_7nm_nfet spiceprefix=X l=7e-009 nfin=14}
C {/workspaces/vsd-7nm/asap_7nm_Xschem/asap_7nm_nfet.sym} 260 90 0 0 {name=nfet10 model=asap_7nm_nfet spiceprefix=X l=7e-009 nfin=14}
C {res.sym} 100 70 0 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {res.sym} 250 -30 0 0 {name=R2
value=1k
footprint=1206
device=resistor
m=1}
