# LTC3780 High-Efficiency Buck-Boost Converter - HIGH POWER
# Input: 4.5V - 30V, Output: 12V @ 30A (360W)
# 4-switch synchronous buck-boost topology with paralleled MOSFETs

# Design parameters
$v_in_min [real]= 4.5    # minimum input voltage
$v_in_max [int]= 30     # maximum input voltage
$v_out    [int]= 12     # output voltage
$i_out    [int]= 30     # output current
$f_sw     [int]= 200k   # switching frequency (reduced for high current)

# Current sense: 50mV threshold / 35A peak = ~1.43mOhm
$r_sense  [real]= 1.5m   # current sense resistance
$r_freq   [int]= 150k   # frequency set resistor (~200kHz)

# =====================================================================
# CONTROLLER
# =====================================================================
elec.part "U1": ltc3780()                                                                    ; des = "LTC3780 buck-boost controller"                                   ; fp = "Package_DIP:DIP-16_W7.62mm"
elec.part "U2": mosfet_driver( type = "UCC27524A" )                                          ; des = "Dual 5A gate driver, non-inverting"                              ; fp = "Package_DIP:DIP-8_W7.62mm"
elec.part "U3": mosfet_driver( type = "UCC27524A" )                                          ; des = "Dual 5A gate driver, non-inverting"                              ; fp = "Package_DIP:DIP-8_W7.62mm"

# =====================================================================
# POWER MOSFETs - 4x paralleled per position for 30A+ capability
# =====================================================================
elec.part [ "Q1a", "Q1b", "Q1c", "Q1d" ]: mosfet( type = "IRF4905PBF" )                    ; des = "P-Ch MOSFET, -75A, -55V, 5.3mOhm, TO-220"                        ; fp = "Package_TO_SOT_THT:TO-220-3_Vertical"
elec.part [ "Q2a", "Q2b", "Q2c", "Q2d" ]: mosfet( type = "IRFB3077PBF" )                  ; des = "N-Ch MOSFET, 162A, 75V, 3.3mOhm, TO-220"                         ; fp = "Package_TO_SOT_THT:TO-220-3_Vertical"
elec.part [ "Q3a", "Q3b", "Q3c", "Q3d" ]: mosfet( type = "IRF4905PBF" )                    ; des = "P-Ch MOSFET, -75A, -55V, 5.3mOhm, TO-220"                        ; fp = "Package_TO_SOT_THT:TO-220-3_Vertical"
elec.part [ "Q4a", "Q4b", "Q4c", "Q4d" ]: mosfet( type = "IRFB3077PBF" )                  ; des = "N-Ch MOSFET, 162A, 75V, 3.3mOhm, TO-220"                         ; fp = "Package_TO_SOT_THT:TO-220-3_Vertical"

# =====================================================================
# INDUCTOR - High current toroidal
# =====================================================================
elec.part "L1": l( L = 4.7u, I = 50, R = 5m )                                              ; des = "Toroidal inductor, 4.7uH, 50A sat, 5mOhm DCR"                    ; fp = "Inductor_THT:Inductor_D25.0mm_W25.0mm_P20.00mm_Horizontal"

# =====================================================================
# BOOTSTRAP DIODE - Fast recovery
# =====================================================================
elec.part "D1": d( type = "MBR20100CT" )                                                    ; des = "Dual Schottky, 20A, 100V"                                         ; fp = "Package_TO_SOT_THT:TO-220-3_Vertical"

# =====================================================================
# INPUT CAPACITORS - Low ESR ceramic + bulk electrolyte
# =====================================================================
elec.part [ "C1", "C2", "C3", "C4" ]: nonpol_c( C = 100u, V = 50, type = "ceramic" )       ; des = "Input MLCC caps, X5R, low ESR"                                    ; fp = "Capacitor_SMD:C_1210_3225Metric"
elec.part [ "C5", "C6" ]: pol_c( C = 1000u, V = 50, type = "aluminium polymer" )           ; des = "Input bulk caps, polymer electrolytic"                             ; fp = "Capacitor_THT:CP_Radial_D16.0mm_P7.50mm"

# =====================================================================
# OUTPUT CAPACITORS - Multiple paralleled for low ESR
# =====================================================================
elec.part [ "C7", "C8", "C9", "C10" ]: nonpol_c( C = 100u, V = 25, type = "ceramic" )      ; des = "Output MLCC caps, X5R, low ESR"                                   ; fp = "Capacitor_SMD:C_1210_3225Metric"
elec.part [ "C11", "C12" ]: pol_c( C = 2200u, V = 25, type = "aluminium polymer" )         ; des = "Output bulk caps, polymer electrolytic"                            ; fp = "Capacitor_THT:CP_Radial_D18.0mm_P7.50mm"

# =====================================================================
# BYPASS / DECOUPLING CAPACITORS
# =====================================================================
elec.part [ "C13", "C14", "C15" ]: nonpol_c( C = 100n, V = 50, type = "ceramic" )          ; des = "Controller bypass caps"                                            ; fp = "Capacitor_SMD:C_0805_2012Metric"
elec.part "C16": nonpol_c( C = 10u, V = 16, type = "ceramic" )                              ; des = "Bootstrap cap"                                                     ; fp = "Capacitor_SMD:C_0805_2012Metric"
elec.part "C17": nonpol_c( C = 1u, V = 16, type = "ceramic" )                               ; des = "Soft-start cap"                                                    ; fp = "Capacitor_SMD:C_0805_2012Metric"
elec.part [ "C18", "C19" ]: nonpol_c( C = 47u, V = 16, type = "ceramic" )                  ; des = "Driver bypass caps"                                                ; fp = "Capacitor_SMD:C_1210_32225Metric"

# =====================================================================
# CURRENT SENSE - Low value, high power
# =====================================================================
elec.part "R1": r( R = 1.5m, P = 5, type = "power metal film" )                            ; des = "Current sense resistor, 1.5mOhm, 5W"                              ; fp = "Resistor_SMD:R_2512_6332Metric"
elec.part "R2": r( R = 10k, P = 0.25, type = "metal film" )                                ; des = "Sense filter resistor"                                             ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part "C20": nonpol_c( C = 1n, V = 16, type = "ceramic" )                              ; des = "Sense filter cap"                                                  ; fp = "Capacitor_SMD:C_0805_2012Metric"

# =====================================================================
# FEEDBACK RESISTORS - Sets output voltage
# =====================================================================
elec.part "R3": r( R = 47k, P = 0.25, type = "metal film" )                                ; des = "Feedback divider top"                                              ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part "R4": r( R = 3.3k, P = 0.25, type = "metal film" )                               ; des = "Feedback divider bottom"                                           ; fp = "Resistor_SMD:R_0805_2012Metric"

# =====================================================================
# FREQUENCY / COMPENSATION / SOFT-START
# =====================================================================
elec.part "R5": r( R = $r_freq, P = 0.25, type = "metal film" )                            ; des = "Frequency set resistor"                                            ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part "R6": r( R = 10k, P = 0.25, type = "metal film" )                                ; des = "ITH compensation resistor"                                         ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part "C21": nonpol_c( C = 4.7n, V = 16, type = "ceramic" )                            ; des = "ITH compensation cap"                                              ; fp = "Capacitor_SMD:C_0805_2012Metric"
elec.part "C22": nonpol_c( C = 220p, V = 16, type = "ceramic" )                            ; des = "ITH compensation cap (hf)"                                        ; fp = "Capacitor_SMD:C_0805_2012Metric"

# =====================================================================
# GATE RESISTORS - Limit dV/dt
# =====================================================================
elec.part [ "R7", "R8", "R9", "R10" ]: r( R = 4.7, P = 0.5, type = "carbon" )             ; des = "Gate resistors, limit dV/dt"                                       ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part [ "R11", "R12", "R13", "R14" ]: r( R = 10k, P = 0.25, type = "metal film" )     ; des = "Gate pull-down resistors"                                          ; fp = "Resistor_SMD:R_0805_2012Metric"

# =====================================================================
# ENABLE / PULLUP
# =====================================================================
elec.part "R15": r( R = 10k, P = 0.25, type = "metal film" )                               ; des = "RUN pin pullup"                                                    ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part "JP1": pinheader( N = 2 )                                                         ; des = "Enable jumper"                                                     ; fp = "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical"

# =====================================================================
# CONNECTORS - High current
# =====================================================================
elec.part "J1": pinheader( N = 3 )                                                          ; des = "Input connector, 30A rated"                                        ; fp = "TerminalBlock_CUI:TerminalBlock_CUI_TB007-508-03_1x03_P5.08mm_Horizontal"
elec.part "J2": pinheader( N = 2 )                                                          ; des = "Output connector, 30A rated"                                       ; fp = "TerminalBlock_CUI:TerminalBlock_CUI_TB007-508-02_1x02_P5.08mm_Horizontal"
elec.part "TP1": testpoint()                                                                ; des = "Output voltage test point"                                         ; fp = "TestPoint:TestPoint_Pad_1.0x1.0mm"
elec.part "TP2": testpoint()                                                                ; des = "Switch node test point"                                            ; fp = "TestPoint:TestPoint_Pad_1.0x1.0mm"

# =====================================================================
# NETS
# =====================================================================
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

# =====================================================================
# INPUT POWER BUS
# =====================================================================
elec.connect Vin   J1[1] C1[1] C2[1] C3[1] C4[1] C5[+] C6[+]

# High-side P-MOSFETs Q1 (input side) - all sources to Vin
elec.connect Vin   Q1a[s] Q1b[s] Q1c[s] Q1d[s]

# Low-side N-MOSFETs Q2 (input side) - all sources to sense resistor
elec.connect Vsw_l Q2a[s] Q2b[s] Q2c[s] Q2d[s]

# Q1 drains to Q2 drains = switch node high
elec.connect Vsw_h Q1a[d] Q1b[d] Q1c[d] Q1d[d] Q2a[d] Q2b[d] Q2c[d] Q2d[d]

# =====================================================================
# OUTPUT POWER BUS
# =====================================================================
elec.connect Vout  J2[1] C7[1] C8[1] C9[1] C10[1] C11[+] C12[+] TP1[1]

# High-side P-MOSFETs Q3 (output side) - all sources to Vout
elec.connect Vout  Q3a[s] Q3b[s] Q3c[s] Q3d[s]

# Low-side N-MOSFETs Q4 (output side) - all sources to Gnd
elec.connect Gnd   Q4a[s] Q4b[s] Q4c[s] Q4d[s]

# Q3 drains to Q4 drains = switch node low
elec.connect Vsw_l Q3a[d] Q3b[d] Q3c[d] Q3d[d] Q4a[d] Q4b[d] Q4c[d] Q4d[d]

# =====================================================================
# INDUCTOR & BOOTSTRAP
# =====================================================================
elec.connect Vsw_h L1[1] D1[a]
elec.connect Vsw_l L1[2] D1[k]

# =====================================================================
# CURRENT SENSE
# =====================================================================
elec.connect Vsp   R1[1] Q2a[s] Q2b[s] Q2c[s] Q2d[s]
elec.connect Vsn   R1[2] R2[1] C20[1] Gnd
elec.connect Vsn   U1[sense-]
elec.connect Vsp   U1[sense+]
elec.connect R2[2] C20[2]

# =====================================================================
# CONTROLLER
# =====================================================================
elec.connect Vin   U1[vin] C13[1]
elec.connect Gnd   U1[gnd] C13[2]

# RUN enable (jumper to Vin through R15)
elec.connect Vin   JP1[1] R15[1]
elec.connect Vcc   JP1[2] R15[2] U1[run]

# Feedback
elec.connect Vout  R3[1]
elec.connect Vfb   R3[2] R4[1] U1[fb]
elec.connect Gnd   R4[2]

# Frequency
elec.connect U1[freq] R5[1]
elec.connect Gnd       R5[2]

# Compensation (ITH)
elec.connect U1[ith] R6[1] C21[1]
elec.connect C21[2]  C22[1] Gnd
elec.connect C22[2]  Gnd
elec.connect R6[2]   Gnd

# Soft-start
elec.connect U1[ss]  C17[1]
elec.connect Gnd     C17[2]

# Bootstrap
elec.connect Vout    C16[1] U1[boost]
elec.connect Gnd     C16[2]

# Switch node sense
elec.connect Vsw_h   U1[sw] TP2[1]

# =====================================================================
# GATE DRIVERS
# =====================================================================
# Driver U2 drives Q1 (input high-side) and Q2 (input low-side)
elec.connect Vin   U2[vcc] C18[1]
elec.connect Gnd   U2[gnd] C18[2]
elec.connect U1[tg] R7[1] U2[in1]
elec.connect U1[bg] R8[1] U2[in2]
elec.connect R7[2]  Q1a[g] Q1b[g] Q1c[g] Q1d[g] R11[1]
elec.connect R8[2]  Q2a[g] Q2b[g] Q2c[g] Q2d[g] R12[1]
elec.connect Gnd    R11[2] R12[2]

# Driver U3 drives Q3 (output high-side) and Q4 (output low-side)
elec.connect Vout  U3[vcc] C19[1]
elec.connect Gnd   U3[gnd] C19[2]
elec.connect U1[ext] R9[1] U3[in1]
elec.connect Gnd    R10[1] U3[in2]
elec.connect R9[2]  Q3a[g] Q3b[g] Q3c[g] Q3d[g] R13[1]
elec.connect R10[2] Q4a[g] Q4b[g] Q4c[g] Q4d[g] R14[1]
elec.connect Gnd    R13[2] R14[2]

# =====================================================================
# GROUND CONNECTIONS
# =====================================================================
elec.connect Gnd  J1[2] J2[2] C5[-] C6[-] C11[-] C12[-] C14[1] C15[1]
elec.connect Gnd  Q4a[s] Q4b[s] Q4c[s] Q4d[s] R4[2] R15[2]

# =====================================================================
# PHYSICAL CONSTRAINTS
# =====================================================================
phys.board N = 6 T = [0.3m, 2.0m] * 2 + [0.3m] W = [4] + [2] * 4 + [4] M = ["FR4", "copper", "ENIG"]

# Input MOSFET group
$q1_group [set]= { Q1a, Q1b, Q1c, Q1d }
$q2_group [set]= { Q2a, Q2b, Q2c, Q2d }
$q3_group [set]= { Q3a, Q3b, Q3c, Q3d }
$q4_group [set]= { Q4a, Q4b, Q4c, Q4d }

# Keep input caps close to Q1/Q2
$in_caps [set]= { C1, C2, C3, C4, C5, C6 }
$out_caps [set]= { C7, C8, C9, C10, C11, C12 }

phys.prox $in_caps $q1_group max = 20m -imp
phys.prox $in_caps $q2_group max = 20m -imp
phys.prox $out_caps $q3_group max = 20m -imp
phys.prox $out_caps $q4_group max = 20m -imp

# Minimize hot loop inductance
$hotloop_in [set]= { C1[1], Q1a[s], Q1a[d], Q2a[d], Q2a[s], R1[1] }
$hotloop_out [set]= { C7[1], Q3a[s], Q3a[d], Q4a[d], Q4a[s], L1[2] }
phys.prox $hotloop_in minim -vimp
phys.prox $hotloop_out minim -vimp

# Input/output isolation
$insys  [set]= E@^input u { ( J1[1] | C1[1] | C2[1] | C3[1] | C4[1] | C5[+] | C6[+] ) }
$outsys [set]= E@^output u { ( J2[1] | C7[1] | C8[1] | C9[1] | C10[1] | C11[+] | C12[+] ) }
phys.prox $insys $outsys min = 20m -imp

# High current paths - input bus
$hv_in_bus [set]= C@^input u { ( J1[1] | Q1a[s] | Q1b[s] | Q1c[s] | Q1d[s] ) }
phys.connectioncurrent $hv_in_bus 35 -vimp

# High current paths - output bus
$hv_out_bus [set]= C@^output u { ( J2[1] | Q3a[s] | Q3b[s] | Q3c[s] | Q3d[s] ) }
phys.connectioncurrent $hv_out_bus 35 -vimp

# High current paths - switch node
$hv_sw_bus [set]= C@^switching u { ( Q1a[d] | Q2a[d] | L1[1] ) }
phys.connectioncurrent $hv_sw_bus 35 -vimp

# Inductor placement
phys.prox L1 $q1_group max = 25m -imp
phys.prox L1 $q3_group max = 25m -imp

# Gate drive routing symmetry
phys.connmatch imp ( U2[in1] | U2[in2] ) -imp
phys.connmatch imp ( U3[in1] | U3[in2] ) -imp

# Switching node on inner layer 2 for EMI reduction
phys.layer { Q1a[d], Q1b[d], Q1c[d], Q1d[d], Q2a[d], Q2b[d], Q2c[d], Q2d[d], L1[1] } 1 -imp

# Power planes on layers 1 and 4
phys.layer { Vin } 0 -imp
phys.layer { Vout } 5 -imp

# Ground planes on layers 2 and 5
phys.mkplane 2 Gnd
phys.mkplane 5 Gnd

# Via stitching for thermal and current sharing
phys.viafill Q1a[d] v = 0.4m d = 1.5m
phys.viafill Q1b[d] v = 0.4m d = 1.5m
phys.viafill Q1c[d] v = 0.4m d = 1.5m
phys.viafill Q1d[d] v = 0.4m d = 1.5m
phys.viafill Q3a[d] v = 0.4m d = 1.5m
phys.viafill Q3b[d] v = 0.4m d = 1.5m
phys.viafill Q3c[d] v = 0.4m d = 1.5m
phys.viafill Q3d[d] v = 0.4m d = 1.5m

# Align MOSFET groups for thermal management
phys.align [ Q1a, Q1b, Q1c, Q1d ] axis = x d = 2m -imp
phys.align [ Q2a, Q2b, Q2c, Q2d ] axis = x d = 2m -imp
phys.align [ Q3a, Q3b, Q3c, Q3d ] axis = x d = 2m -imp
phys.align [ Q4a, Q4b, Q4c, Q4d ] axis = x d = 2m -imp

# Component layer assignments
phys.layer *p 0 -oeo
phys.layer *b 5 -oeo

phys.mkpcb

halt
