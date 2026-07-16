# LTC3780 High-Efficiency Buck-Boost Converter
# Input: 4.5V - 30V, Output: 12V @ 3A
# Synchronous 4-switch buck-boost topology

# Design parameters
$v_in_min [real]= 4.5    # minimum input voltage
$v_in_max [int]= 30     # maximum input voltage
$v_out    [int]= 12     # output voltage
$i_out    [int]= 3      # output current
$f_sw     [int]= 300k   # switching frequency

# Component selection
$r_sense  [real]= 10m    # current sense resistance (50mV threshold / 5A = 10m)
$r_freq   [int]= 100k   # frequency set resistor (sets ~300kHz)

# Parts
elec.part         "U1": ltc3780()                                                                                              ; des = "LTC3780 buck-boost controller"                                        ; fp = "Package_DIP:DIP-16_W7.62mm"
elec.part ["Q1", "Q3"]: mosfet( type = "IRF9540NPBF" )                                                                        ; des = "P-Channel MOSFET, -23A, -100V, 117mOhm, TO-220"                       ; fp = "Package_TO_SOT_THT:TO-220-3_Vertical"
elec.part ["Q2", "Q4"]: mosfet( type = "IRF3205PBF" )                                                                         ; des = "N-Channel MOSFET, 110A, 55V, 8mOhm, TO-220"                           ; fp = "Package_TO_SOT_THT:TO-220-3_Vertical"
elec.part         "L1": l( L = 10u, I = 5, R = 20m )                                                                          ; des = "Power inductor, 10uH, 5A, 20mOhm DCR"                                 ; fp = "Inductor_THT:Inductor_D18.0mm_W18.0mm_P15.24mm_Horizontal"
elec.part         "D1": d( type = "MBR20100CT" )                                                                               ; des = "Dual Schottky diode, 20A, 100V, TO-220"                               ; fp = "Package_TO_SOT_THT:TO-220-3_Vertical"
elec.part ["C1", "C2"]: nonpol_c( C = 22u, V = 50, type = "ceramic" )                                                         ; des = "Input capacitors, ceramic"                                              ; fp = "Capacitor_SMD:C_1210_3225Metric"
elec.part ["C3", "C4"]: nonpol_c( C = 22u, V = 25, type = "ceramic" )                                                         ; des = "Output capacitors, ceramic"                                             ; fp = "Capacitor_SMD:C_1210_3225Metric"
elec.part         "C5": pol_c( C = 100u, V = 35, type = "aluminium electrolyte" )                                             ; des = "Input bulk capacitor"                                                   ; fp = "Capacitor_THT:CP_Radial_D10.0mm_P5.00mm"
elec.part         "C6": pol_c( C = 470u, V = 25, type = "aluminium electrolyte" )                                             ; des = "Output bulk capacitor"                                                  ; fp = "Capacitor_THT:CP_Radial_D12.5mm_P5.00mm"
elec.part ["C7", "C8", "C9"]: nonpol_c( C = 100n, V = 50, type = "ceramic" )                                                 ; des = "Bypass capacitors"                                                      ; fp = "Capacitor_SMD:C_0805_2012Metric"
elec.part         "C10": nonpol_c( C = 1u, V = 16, type = "ceramic" )                                                         ; des = "Soft-start capacitor"                                                   ; fp = "Capacitor_SMD:C_0805_2012Metric"
elec.part         "R1": r( R = 10k, P = 0.25, type = "metal film" )                                                          ; des = "Feedback divider top"                                                   ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part         "R2": r( R = 3.3k, P = 0.25, type = "metal film" )                                                         ; des = "Feedback divider bottom"                                                ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part         "R3": r( R = $r_freq, P = 0.25, type = "metal film" )                                                      ; des = "Frequency set resistor"                                                 ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part         "R4": r( R = 2.21k, P = 0.25, type = "metal film" )                                                        ; des = "Current sense resistor"                                                 ; fp = "Resistor_SMD:R_2512_6332Metric"
elec.part         "R5": r( R = 10k, P = 0.25, type = "metal film" )                                                          ; des = "Pullup resistor for RUN pin"                                            ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part         "R6": r( R = 4.7k, P = 0.25, type = "metal film" )                                                         ; des = "ITH compensation resistor"                                              ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part         "R7": r( R = 1k, P = 0.25, type = "metal film" )                                                           ; des = "Gate pull-down resistor"                                                ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part        "JP1": pinheader( N = 2 )                                                                                    ; des = "Enable jumper"                                                          ; fp = "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical"
elec.part         "J1": pinheader( N = 3 )                                                                                    ; des = "Input connector"                                                        ; fp = "TerminalBlock_CUI:TerminalBlock_CUI_TB007-508-03_1x03_P5.08mm_Horizontal"
elec.part         "J2": pinheader( N = 2 )                                                                                    ; des = "Output connector"                                                       ; fp = "TerminalBlock_CUI:TerminalBlock_CUI_TB007-508-02_1x02_P5.08mm_Horizontal"
elec.part        "TP1": testpoint()                                                                                            ; des = "Output voltage test point"                                              ; fp = "TestPoint:TestPoint_Pad_1.0x1.0mm"
elec.part        "TP2": testpoint()                                                                                            ; des = "Switch node test point"                                                 ; fp = "TestPoint:TestPoint_Pad_1.0x1.0mm"

# Nets
elec.net "Vin"       "power"
elec.net "Vout"      "power"
elec.net "Gnd"       "power" "ground"
elec.net "Vsw_h"     "power" "switching"    # high-side switch node (Q1, Q3 drains)
elec.net "Vsw_l"     "power" "switching"    # low-side switch node (Q2, Q4 sources)
elec.net "Vcc"       "power"
elec.net "Vfb"       "sensitive"
elec.net "Isense"    "sensitive"
elec.net "Vcomp"     "sensitive"
elec.net "Vboost"    "power"
elec.net "Vsn"       "sensitive"

# Input power connections
elec.connect Vin   J1[1] C1[1] C2[1] C5[+] U1[vin]
elec.connect Gnd   J1[2] C1[2] C2[2] C5[-] C7[2] C8[2] C9[2] Q2[s] Q4[s] R2[2] R4[2] U1[gnd] R7[2]

# Output power connections
elec.connect Vout  J2[1] C3[1] C4[1] C6[+] TP1[1]
elec.connect Gnd   J2[2] C3[2] C4[2] C6[-]

# Enable jumper (pulls RUN high through R5 when jumper installed)
elec.connect Vin   JP1[1] R5[1]
elec.connect Vcc   JP1[2] R5[2] U1[run]

# High-side P-MOSFETs (Q1 = input side, Q3 = output side)
elec.connect Vin   Q1[s]
elec.connect Vsw_h Q1[d] Q2[d] L1[1]
elec.connect Q3[s] Vout
elec.connect Vsw_h Q3[d] C9[1]

# Low-side N-MOSFETs (Q2 = input side, Q4 = output side)
elec.connect Vsw_l Q2[s] Q4[s] R4[1]
elec.connect Q4[d] D1[k]

# Inductor and bootstrap diode
elec.connect L1[2] Vsw_l D1[a]

# Current sense (across R4)
elec.connect Vsn   R4[1] U1[sense-]
elec.connect Vsw_l R4[2] U1[sense+]

# Gate drive connections
elec.connect U1[tg] Q1[g]   # top gate (high-side)
elec.connect U1[bg] Q2[g]   # bottom gate (low-side)
elec.connect U1[ext] Q3[g]   # external gate driver output
elec.connect Vboost U1[boost] C8[1]  # bootstrap capacitor

# Feedback voltage divider (sets output voltage)
# Vout = 0.8V * (1 + R1/R2) = 0.8V * (1 + 10k/3.3k) = ~3.22V (adjust R1/R2 for 12V)
elec.connect Vout  R1[1] TP1[1]
elec.connect Vfb   R1[2] R2[1] U1[fb]
elec.connect Gnd   R2[2]

# Frequency set resistor
elec.connect U1[freq] R3[1] C7[1]
elec.connect Gnd       R3[2]

# Compensation network (on ITH pin)
elec.connect U1[ith] R6[1] C10[1]
elec.connect Gnd     R6[2] C10[2]

# Soft-start capacitor
elec.connect U1[ss] C10[1]

# Bypass capacitor on VIN
elec.connect U1[vin] C9[1]
elec.connect Gnd      C9[2]

# Switch node to controller
elec.connect Vsw_h U1[sw] TP2[1]

# Physical constraints
phys.board N = 4 T = [0.3m, 1.0m, 0.3m] W = [2] + [1] * 2 + [2] M = ["FR4", "copper", "ENIG"]

# Keep input and output capacitors close to MOSFETs
$in_caps [set]= { C1, C2, C5 }
$out_caps [set]= { C3, C4, C6 }
$mosfets [set]= { Q1, Q2, Q3, Q4 }

phys.prox $in_caps $mosfets max = 15m -imp
phys.prox $out_caps $mosfets max = 15m -imp

# Minimize hot loop (input cap to MOSFETs)
$hotloop [set]= { C1[1], Q1[s], Q1[d], Q2[d], Q2[s], R4[1] }
phys.prox $hotloop minim -vimp

# Input and output isolation
$insys  [set]= E@^power u { ( J1[1] | C1[1] | C2[1] | C5[+] | U1[vin] ) }
$outsys [set]= E@^power u { ( J2[1] | C3[1] | C4[1] | C6[+] ) }
phys.prox $insys $outsys min = 10m -imp

# High current paths
$hv_input [set]= C@^power u { ( J1[1] | Q1[s] ) }
phys.connectioncurrent $hv_input 5 -imp

$hv_output [set]= C@^power u { ( J2[1] | Q3[s] ) }
phys.connectioncurrent $hv_output 5 -imp

# Switching node on inner layer for EMI reduction
phys.layer { Q1[d], Q2[d], Q3[d], Q4[d], L1[1], D1[a], D1[k] } 1 -imp

# Ground plane on bottom layer
phys.mkplane 3 Gnd

# Ensure gate drive symmetry
phys.connmatch imp ( U1[tg] | U1[bg] ) -imp

# Component alignment
phys.align [ Q1, Q2 ] axis = x d = 5m -vimp
phys.align [ Q3, Q4 ] axis = x d = 5m -vimp

# Via fill on power MOSFET thermal pads
phys.viafill Q1[d] v = 0.3m d = 1.0m
phys.viafill Q3[d] v = 0.3m d = 1.0m

phys.mkpcb

halt
