#c# LTC3780 High-Efficiency Buck-Boost Converter - HIGH POWER
#c# Input: 4.5V - 30V, Output: 12V @ 30A (360W)
#c# 4-switch synchronous buck-boost topology with DirectFET MOSFETs

#c# Design parameters
$v_in_min [real]= 4.5    #c# minimum input voltage
$v_in_max [int]= 30     #c# maximum input voltage
$v_out    [int]= 12     #c# output voltage
$i_out    [int]= 30     #c# output current
$f_sw     [int]= 300k   #c# switching frequency

#c# Current sense: 50mV threshold / 35A peak = ~1.43mOhm
$r_sense  [real]= 1.5m   #c# current sense resistance
$r_freq   [int]= 100k   #c# frequency set resistor (~300kHz)

#c# =====================================================================
#c# CONTROLLER
#c# =====================================================================
elec.part "U1": ltc3780()                                                                    ; des = "LTC3780 buck-boost controller"                                   ; fp = "Package_DIP:DIP-16_W7.62mm"
elec.part "U2": mosfet_driver( type = "LTC4449" )                                           ; des = "6A gate driver, low-side"                                        ; fp = "Package_SOT:SOT-23-6"
elec.part "U3": mosfet_driver( type = "LTC4449" )                                           ; des = "6A gate driver, low-side"                                        ; fp = "Package_SOT:SOT-23-6"
elec.part "U4": mosfet_driver( type = "LTC4447" )                                           ; des = "6A gate driver, high-side"                                       ; fp = "Package_SOT:SOT-23-6"
elec.part "U5": mosfet_driver( type = "LTC4447" )                                           ; des = "6A gate driver, high-side"                                       ; fp = "Package_SOT:SOT-23-6"

#c# =====================================================================
#c# POWER MOSFETs - DirectFET, 0.5mOhm, 3x paralleled per position
#c# =====================================================================
elec.part [ "Q1a", "Q1b", "Q1c" ]: mosfet( type = "IRF6795PBF" )                           ; des = "P-Ch DirectFET, -100A, -40V, 0.65mOhm"                           ; fp = "Package_DirectFET:DirectFET_ISO"
elec.part [ "Q2a", "Q2b", "Q2c" ]: mosfet( type = "IRF6725PBF" )                           ; des = "N-Ch DirectFET, 150A, 25V, 0.5mOhm"                              ; fp = "Package_DirectFET:DirectFET_ISO"
elec.part [ "Q3a", "Q3b", "Q3c" ]: mosfet( type = "IRF6795PBF" )                           ; des = "P-Ch DirectFET, -100A, -40V, 0.65mOhm"                           ; fp = "Package_DirectFET:DirectFET_ISO"
elec.part [ "Q4a", "Q4b", "Q4c" ]: mosfet( type = "IRF6725PBF" )                           ; des = "N-Ch DirectFET, 150A, 25V, 0.5mOhm"                              ; fp = "Package_DirectFET:DirectFET_ISO"

#c# =====================================================================
#c# INDUCTOR - High current toroidal
#c# =====================================================================
elec.part "L1": l( L = 4.7u, I = 50, R = 3m )                                              ; des = "Toroidal inductor, 4.7uH, 50A sat, 3mOhm DCR"                   ; fp = "Inductor_THT:Inductor_D30.0mm_W30.0mm_P25.00mm_Horizontal"

#c# =====================================================================
#c# BOOTSTRAP DIODE - Fast recovery
#c# =====================================================================
elec.part "D1": d( type = "MBR2045CT" )                                                     ; des = "Dual Schottky, 20A, 45V"                                          ; fp = "Package_TO_SOT_THT:TO-220-3_Vertical"

#c# =====================================================================
#c# INPUT CAPACITORS - Low ESR ceramic + bulk polymer
#c# =====================================================================
elec.part [ "C1", "C2", "C3", "C4", "C5", "C6" ]: nonpol_c( C = 100u, V = 50, type = "ceramic" )   ; des = "Input MLCC caps, X5R, low ESR"                           ; fp = "Capacitor_SMD:C_1210_3225Metric"
elec.part [ "C7", "C8" ]: pol_c( C = 470u, V = 50, type = "aluminium polymer" )            ; des = "Input bulk caps, polymer electrolytic"                            ; fp = "Capacitor_THT:CP_Radial_D10.0mm_P5.00mm"

#c# =====================================================================
#c# OUTPUT CAPACITORS - Multiple paralleled for low ESR
#c# =====================================================================
elec.part [ "C9", "C10", "C11", "C12", "C13", "C14" ]: nonpol_c( C = 100u, V = 25, type = "ceramic" ) ; des = "Output MLCC caps, X5R, low ESR"                  ; fp = "Capacitor_SMD:C_1210_3225Metric"
elec.part [ "C15", "C16" ]: pol_c( C = 1000u, V = 25, type = "aluminium polymer" )         ; des = "Output bulk caps, polymer electrolytic"                            ; fp = "Capacitor_THT:CP_Radial_D12.5mm_P5.00mm"

#c# =====================================================================
#c# BYPASS / DECOUPLING CAPACITORS
#c# =====================================================================
elec.part [ "C17", "C18", "C19" ]: nonpol_c( C = 100n, V = 50, type = "ceramic" )          ; des = "Controller bypass caps"                                            ; fp = "Capacitor_SMD:C_0805_2012Metric"
elec.part "C20": nonpol_c( C = 4.7u, V = 16, type = "ceramic" )                             ; des = "Bootstrap cap"                                                     ; fp = "Capacitor_SMD:C_0805_2012Metric"
elec.part "C21": nonpol_c( C = 1u, V = 16, type = "ceramic" )                               ; des = "Soft-start cap"                                                    ; fp = "Capacitor_SMD:C_0805_2012Metric"
elec.part [ "C22", "C23", "C24", "C25" ]: nonpol_c( C = 22u, V = 16, type = "ceramic" )    ; des = "Driver bypass caps"                                                ; fp = "Capacitor_SMD:C_0805_2012Metric"

#c# =====================================================================
#c# CURRENT SENSE - Low value, high power
#c# =====================================================================
elec.part "R1": r( R = 1.5m, P = 5, type = "power metal film" )                            ; des = "Current sense resistor, 1.5mOhm, 5W"                              ; fp = "Resistor_SMD:R_2512_6332Metric"

#c# =====================================================================
#c# FEEDBACK RESISTORS - Sets output voltage
#c# =====================================================================
elec.part "R2": r( R = 47k, P = 0.25, type = "metal film" )                                ; des = "Feedback divider top"                                              ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part "R3": r( R = 3.3k, P = 0.25, type = "metal film" )                               ; des = "Feedback divider bottom"                                           ; fp = "Resistor_SMD:R_0805_2012Metric"

#c# =====================================================================
#c# FREQUENCY / COMPENSATION / SOFT-START
#c# =====================================================================
elec.part "R4": r( R = $r_freq, P = 0.25, type = "metal film" )                            ; des = "Frequency set resistor"                                            ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part "R5": r( R = 10k, P = 0.25, type = "metal film" )                                ; des = "ITH compensation resistor"                                         ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part "C26": nonpol_c( C = 4.7n, V = 16, type = "ceramic" )                            ; des = "ITH compensation cap"                                              ; fp = "Capacitor_SMD:C_0805_2012Metric"
elec.part "C27": nonpol_c( C = 220p, V = 16, type = "ceramic" )                            ; des = "ITH compensation cap (hf)"                                        ; fp = "Capacitor_SMD:C_0805_2012Metric"

#c# =====================================================================
#c# GATE RESISTORS - Limit dV/dt
#c# =====================================================================
elec.part [ "R6", "R7", "R8", "R9" ]: r( R = 2.2, P = 0.5, type = "carbon" )              ; des = "Gate resistors, limit dV/dt"                                       ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part [ "R10", "R11", "R12", "R13" ]: r( R = 10k, P = 0.25, type = "metal film" )     ; des = "Gate pull-down resistors"                                          ; fp = "Resistor_SMD:R_0805_2012Metric"

#c# =====================================================================
#c# ENABLE / PULLUP
#c# =====================================================================
elec.part "R14": r( R = 10k, P = 0.25, type = "metal film" )                               ; des = "RUN pin pullup"                                                    ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part "JP1": pinheader( N = 2 )                                                         ; des = "Enable jumper"                                                     ; fp = "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical"

#c# =====================================================================
#c# CONNECTORS - High current
#c# =====================================================================
elec.part "J1": pinheader( N = 3 )                                                          ; des = "Input connector, 30A rated"                                        ; fp = "TerminalBlock_CUI:TerminalBlock_CUI_TB007-508-03_1x03_P5.08mm_Horizontal"
elec.part "J2": pinheader( N = 2 )                                                          ; des = "Output connector, 30A rated"                                       ; fp = "TerminalBlock_CUI:TerminalBlock_CUI_TB007-508-02_1x02_P5.08mm_Horizontal"
elec.part "TP1": testpoint()                                                                ; des = "Output voltage test point"                                         ; fp = "TestPoint:TestPoint_Pad_1.0x1.0mm"
elec.part "TP2": testpoint()                                                                ; des = "Switch node test point"                                            ; fp = "TestPoint:TestPoint_Pad_1.0x1.0mm"

#c# =====================================================================
#c# NETS
#c# =====================================================================
elec.net "Vin"       "power" "input"
elec.net "Vout"      "power" "output"
elec.net "Gnd"       "power" "ground"
elec.net "Vsw_h"     "power" "switching"
elec.net "Vsw_l"     "power" "switching"
elec.net "Vcc"       "power"
elec.net "Vfb"       "sensitive"
elec.net "Vsn"       "sensitive"
elec.net "Vsp"       "sensitive"
elec.net "Vboost"    "power"
elec.net "Vdrv"      "power"

#c# =====================================================================
#c# INPUT POWER BUS
#c# =====================================================================
elec.connect Vin   J1[1] C1[1] C2[1] C3[1] C4[1] C5[1] C6[1] C7[+] C8[+]

#c# High-side P-MOSFETs Q1 (input side) - all sources to Vin
elec.connect Vin   Q1a[s] Q1b[s] Q1c[s]

#c# Low-side N-MOSFETs Q2 (input side) - all sources to sense resistor
elec.connect Vsw_l Q2a[s] Q2b[s] Q2c[s]

#c# Q1 drains to Q2 drains = switch node high
elec.connect Vsw_h Q1a[d] Q1b[d] Q1c[d] Q2a[d] Q2b[d] Q2c[d]

#c# =====================================================================
#c# OUTPUT POWER BUS
#c# =====================================================================
elec.connect Vout  J2[1] C9[1] C10[1] C11[1] C12[1] C13[1] C14[1] C15[+] C16[+] TP1[1]

#c# High-side P-MOSFETs Q3 (output side) - all sources to Vout
elec.connect Vout  Q3a[s] Q3b[s] Q3c[s]

#c# Low-side N-MOSFETs Q4 (output side) - all sources to Gnd
elec.connect Gnd   Q4a[s] Q4b[s] Q4c[s]

#c# Q3 drains to Q4 drains = switch node low
elec.connect Vsw_l Q3a[d] Q3b[d] Q3c[d] Q4a[d] Q4b[d] Q4c[d]

#c# =====================================================================
#c# INDUCTOR & BOOTSTRAP
#c# =====================================================================
elec.connect Vsw_h L1[1] D1[a]
elec.connect Vsw_l L1[2] D1[k]

#c# =====================================================================
#c# CURRENT SENSE
#c# =====================================================================
elec.connect Vsp   R1[1] Q2a[s] Q2b[s] Q2c[s]
elec.connect Vsn   R1[2] U1[sense-]
elec.connect Vsp   U1[sense+]

#c# =====================================================================
#c# CONTROLLER
#c# =====================================================================
elec.connect Vin   U1[vin] C17[1]
elec.connect Gnd   U1[gnd] C17[2]

#c# RUN enable (jumper to Vin through R14)
elec.connect Vin   JP1[1] R14[1]
elec.connect Vcc   JP1[2] R14[2] U1[run]

#c# Feedback
elec.connect Vout  R2[1]
elec.connect Vfb   R2[2] R3[1] U1[fb]
elec.connect Gnd   R3[2]

#c# Frequency
elec.connect U1[freq] R4[1]
elec.connect Gnd       R4[2]

#c# Compensation (ITH)
elec.connect U1[ith] R5[1] C26[1]
elec.connect C26[2]  C27[1] Gnd
elec.connect C27[2]  Gnd
elec.connect R5[2]   Gnd

#c# Soft-start
elec.connect U1[ss]  C21[1]
elec.connect Gnd     C21[2]

#c# Bootstrap
elec.connect Vout    C20[1] U1[boost]
elec.connect Gnd     C20[2]

#c# Switch node sense
elec.connect Vsw_h   U1[sw] TP2[1]

#c# =====================================================================
#c# GATE DRIVERS
#c# =====================================================================
#c# Driver U2 drives Q1 (input high-side P-channel)
elec.connect Vin   U2[vcc] C22[1]
elec.connect Gnd   U2[gnd] C22[2]
elec.connect U1[tg] R6[1] U2[in]
elec.connect R6[2]  Q1a[g] Q1b[g] Q1c[g] R10[1]
elec.connect Gnd    R10[2]

#c# Driver U3 drives Q2 (input low-side N-channel)
elec.connect Vcc   U3[vcc] C23[1]
elec.connect Gnd   U3[gnd] C23[2]
elec.connect U1[bg] R7[1] U3[in]
elec.connect R7[2]  Q2a[g] Q2b[g] Q2c[g] R11[1]
elec.connect Gnd    R11[2]

#c# Driver U4 drives Q3 (output high-side P-channel)
elec.connect Vout  U4[vcc] C24[1]
elec.connect Gnd   U4[gnd] C24[2]
elec.connect U1[ext] R8[1] U4[in]
elec.connect R8[2]  Q3a[g] Q3b[g] Q3c[g] R12[1]
elec.connect Gnd    R12[2]

#c# Driver U5 drives Q4 (output low-side N-channel)
elec.connect Vcc   U5[vcc] C25[1]
elec.connect Gnd   U5[gnd] C25[2]
elec.connect Gnd   R9[1] U5[in]
elec.connect R9[2]  Q4a[g] Q4b[g] Q4c[g] R13[1]
elec.connect Gnd    R13[2]

#c# =====================================================================
#c# GROUND CONNECTIONS
#c# =====================================================================
elec.connect Gnd  J1[2] J2[2] C7[-] C8[-] C15[-] C16[-] R3[2] R14[2]
elec.connect Gnd  Q4a[s] Q4b[s] Q4c[s]

#c# =====================================================================
#c# PHYSICAL CONSTRAINTS
#c# =====================================================================
phys.board N = 8 T = [0.2m, 2.0m, 0.2m, 0.2m, 2.0m, 0.2m, 0.2m] W = [4] + [2] * 6 + [4] M = ["FR4", "copper", "ENIG"]

#c# DirectFET groups
$q1_group [set]= { Q1a, Q1b, Q1c }
$q2_group [set]= { Q2a, Q2b, Q2c }
$q3_group [set]= { Q3a, Q3b, Q3c }
$q4_group [set]= { Q4a, Q4b, Q4c }

#c# Input/output caps
$in_caps [set]= { C1, C2, C3, C4, C5, C6, C7, C8 }
$out_caps [set]= { C9, C10, C11, C12, C13, C14, C15, C16 }

#c# Keep input caps close to Q1/Q2
phys.prox $in_caps $q1_group max = 15m -imp
phys.prox $in_caps $q2_group max = 15m -imp
phys.prox $out_caps $q3_group max = 15m -imp
phys.prox $out_caps $q4_group max = 15m -imp

#c# Minimize hot loop inductance
$hotloop_in [set]= { C1[1], Q1a[s], Q1a[d], Q2a[d], Q2a[s], R1[1] }
$hotloop_out [set]= { C9[1], Q3a[s], Q3a[d], Q4a[d], Q4a[s], L1[2] }
phys.prox $hotloop_in minim -vimp
phys.prox $hotloop_out minim -vimp

#c# Input/output isolation
$insys  [set]= E@^input u { ( J1[1] | C1[1] | C2[1] | C3[1] | C4[1] | C5[1] | C6[1] | C7[+] | C8[+] ) }
$outsys [set]= E@^output u { ( J2[1] | C9[1] | C10[1] | C11[1] | C12[1] | C13[1] | C14[1] | C15[+] | C16[+] ) }
phys.prox $insys $outsys min = 20m -imp

#c# High current paths - input bus
$hv_in_bus [set]= C@^input u { ( J1[1] | Q1a[s] | Q1b[s] | Q1c[s] ) }
phys.connectioncurrent $hv_in_bus 35 -vimp

#c# High current paths - output bus
$hv_out_bus [set]= C@^output u { ( J2[1] | Q3a[s] | Q3b[s] | Q3c[s] ) }
phys.connectioncurrent $hv_out_bus 35 -vimp

#c# High current paths - switch node
$hv_sw_bus [set]= C@^switching u { ( Q1a[d] | Q2a[d] | L1[1] ) }
phys.connectioncurrent $hv_sw_bus 35 -vimp

#c# Inductor placement
phys.prox L1 $q1_group max = 20m -imp
phys.prox L1 $q3_group max = 20m -imp

#c# Gate drive routing symmetry
phys.connmatch imp ( U2[in] | U3[in] ) -imp
phys.connmatch imp ( U4[in] | U5[in] ) -imp

#c# Switching node on inner layer 2 for EMI reduction
phys.layer { Q1a[d], Q1b[d], Q1c[d], Q2a[d], Q2b[d], Q2c[d], L1[1] } 1 -imp

#c# Power planes on layers 0 and 8
phys.layer { Vin } 0 -imp
phys.layer { Vout } 8 -imp

#c# Ground planes on layers 3 and 6
phys.mkplane 3 Gnd
phys.mkplane 6 Gnd

#c# Via fill on DirectFET thermal pads
phys.viafill Q1a[d] v = 0.2m d = 0.8m
phys.viafill Q1b[d] v = 0.2m d = 0.8m
phys.viafill Q1c[d] v = 0.2m d = 0.8m
phys.viafill Q2a[d] v = 0.2m d = 0.8m
phys.viafill Q2b[d] v = 0.2m d = 0.8m
phys.viafill Q2c[d] v = 0.2m d = 0.8m
phys.viafill Q3a[d] v = 0.2m d = 0.8m
phys.viafill Q3b[d] v = 0.2m d = 0.8m
phys.viafill Q3c[d] v = 0.2m d = 0.8m
phys.viafill Q4a[d] v = 0.2m d = 0.8m
phys.viafill Q4b[d] v = 0.2m d = 0.8m
phys.viafill Q4c[d] v = 0.2m d = 0.8m

#c# Align DirectFET groups for thermal management
phys.align [ Q1a, Q1b, Q1c ] axis = x d = 1m -imp
phys.align [ Q2a, Q2b, Q2c ] axis = x d = 1m -imp
phys.align [ Q3a, Q3b, Q3c ] axis = x d = 1m -imp
phys.align [ Q4a, Q4b, Q4c ] axis = x d = 1m -imp

#c# Component layer assignments
phys.layer *p 0 -oeo
phys.layer *b 8 -oeo

phys.mkpcb

halt
