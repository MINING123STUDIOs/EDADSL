# buck regulator board In: 5-24V, Out: 3.3V 2A

elec.part         "J1": pinheader( N = 4 )                                        ; des = "main io"                                                                                              ; fp = "TerminalBlock_CUI:TerminalBlock_CUI_TB007-508-04_1x04_P5.08mm_Horizontal"
elec.part         "U1": buckregulator( type = "APE1707S-33-HF" )                  ; des = "main switching IC, 2A, 150KHz PWM Buck DC/DC Converter, fixed 3.3V output voltage, TO-263-5 (DD-PAK)" ; fp = "Package_TO_SOT_SMD:TO-263-5_TabPin3"
elec.part         "L1": l( L = 33u, I = 3 )                                       ; des = "main inductor"                                                                                        ; fp = "Inductor_SMD:L_7.3x7.3_H3.5"
elec.part         "D1": d( type = "B340" )                                        ; des = "40V 3A Schottky Barrier Rectifier Diode, SMC"                                                         ; fp = "Diode_SMD:D_SMC"
elec.part ["C1", "C2"]: nonpol_c( C = 100n, V = 35, type = "ceramic" )            ; des = "PSU filtering"                                                                                        ; fp = "Capacitor_SMD:C_0805_2012Metric"
elec.part ["C3", "C4"]: pol_c( C = 470u, V = 35, type = "aluminium electrolyte" ) ; des = "PSU filtering"                                                                                        ; fp = "Capacitor_SMD:CP_Elec_8x6.9"

elec.net "Gnd"
elec.net "Vin"
elec.net "Vout"
elec.net "Vsw"

#       net  J1    J1    C1    C2    C3    C4    D1    U1      U1     L1
elec.connect Gnd  J1[2] J1[4] C1[2] C2[-] C3[2] C4[-] D1[a] U1[vss] U1[en]
elec.connect Vin  J1[1]       C1[1] C2[+]                   U1[vcc]
elec.connect Vout J1[3]                   C3[1] C4[+]                      L1[2]
elec.connect Vsw                                      D1[k] U1[sw]         L1[1]
elec.connect      J1[3]                                     U1[fb]

phys.board N = 2 T = [ 1.6 ] W = [ 2, 2 ] M = ["FR4", "copper"]

$high_current [set]= *c / { ( J1[3] | U1[fb] ) }
phys.connectioncurrent $high_current 3 -vimp

phys.prox { C1[1] } { U1[vcc] } max = 5m -vimp

phys.shrinknet Vsw -imp

$hotloop [set]= { U1[vcc], U1[sw], D1[a], D1[k], C1[1], C1[2] }
phys.prox $hotloop minim -vimp

phys.mkplane 1 Gnd

phys.viafill U1[vss] v = 0.25m d = 0.5m

phys.layer *p 0 -oeo

halt
