#c# high power high current AC and DC solid state relay module. 80A 1kV

#c#part "": (); des = ""; fp = ""
#c#    refrence              part model                                                  part description                                                                                                                           footprint
elec.part       [ "Q1", "Q2" ]: mosfet( type = "C2M0025120D" )                            ; des = "90A Id, 1200V Vds, 25mOhm, N-Channel SiC MOSFET, TO-247"                                                                          ; fp = "Package_TO_SOT_THT:TO-247-3_Horizontal_TabUp"
elec.part               "U1"  : isolator( type = "SFH617A-1" )                            ; des = "Optocoupler, Phototransistor Output, 5300 VRMS, VCEO 70V, CTR% 40-80, -55 to +110 degree Celsius, UL, BSI, FIMKO, cUL, THT PDIP-4"; fp = "Package_DIP:DIP-4_W10.16mm"
elec.part               "U2"  : dcdc_converter( type = "ATA00C18S-L" )                    ; des = "Artesyn 3W Isolated DC/DC Converter Module, 15V Output Voltage, 9-36V Input Voltage, 1.5kV insolation"                            ; fp = "Converter_DCDC:Converter_DCDC_Artesyn_ATA_SMD"
elec.part               "U3"  : gate_driver( type = "TC4422" )                            ; des = "9A High-Speed non-inverting MOSFET Driver"                                                                                        ; fp = "Package_DIP:DIP-8_W7.62mm"
elec.part [ "R1", "R2", "R6" ]: r( R = 10k, P = 0.25, type = "carbon" )                   ; des = "gate bleed resistor"                                                                                                              ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part               "R3"  : r( R = 470, P = 0.25, type = "carbon" )                   ; des = "current limiting resistor for the optoisolator LED"                                                                               ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part       [ "R4", "R5" ]: r( R = 100, P = 0.25, type = "carbon" )                   ; des = "current limiting resistor for the stabilized 3.0V supply"                                                                         ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part       [ "H1", "H2" ]: hole( size = "M6" )                                       ; des = "high current connection points"                                                                                                   ; fp = "MountingHole:MountingHole_6.4mm_M6_Pad_Via"
elec.part       [ "D1", "D2" ]: zener( type = "BZV55B20" )                                ; des = " 20V, 500mW, 2%, Zener diode, MiniMELF"                                                                                           ; fp = "Diode_SMD:D_MiniMELF"
elec.part               "D3"  : zener( type = "BZV55B3V0" )                               ; des = "3.0V, 500mW, 2%, Zener diode, MiniMELF"                                                                                           ; fp = "Diode_SMD:D_MiniMELF"
elec.part [ "C1", "C2", "C5" ]: nonpol_c( C = 100n, V = 35, type = "ceramic" )            ; des = "PSU filtering"                                                                                                                    ; fp = "Capacitor_SMD:C_0805_2012Metric"
elec.part       [ "C3", "C4" ]: pol_c( C = 470u, V = 35, type = "aluminium electrolyte" ) ; des = "PSU filtering"                                                                                                                    ; fp = "Capacitor_SMD:CP_Elec_8x6.9"
elec.part               "J1"  : pinheader( N = 3 )                                        ; des = "main lv side io"                                                                                                                  ; fp = "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical"
elec.part               "Q3"  : mosfet( type = "2N7002H" )                                ; des = "0.21A Id, 60V Vds, N-Channel MOSFET, SOT-23"                                                                                      ; fp = "Package_TO_SOT_SMD:SOT-23"
elec.part              "TP1"  : testpoint( )                                              ; des = "node"                                                                                                                             ; fp = "TestPoint:TestPoint_Pad_1.0x1.0mm"


elec.net "Vswa"   "hv" "I"
elec.net "Vswb"   "hv" "I"

elec.net "Gnd_hv" "hv"
elec.net "Vcc_hv" "hv"
elec.net "sig_hv" "hv"
elec.net "gate"   "hv"
elec.net "gn"     "hv"

elec.net "Gnd_lv" "lv"
elec.net "Vcc_lv" "lv"
elec.net "sig_lv" "lv"
elec.net "Vstab"  "lv"

elec.net "tnet1"  "lv"
elec.net "tnet2"  "lv"
elec.net "tnet3"  "lv"

#c# IO connections
elec.connect Vswa   H1[1] Q1[d]
elec.connect Vswb   H2[1] Q2[d]
elec.connect Gnd_hv Q1[s] Q2[s]

elec.connect Gnd_lv J1[1]
elec.connect sig_lv J1[1] R5[1]
elec.connect Vcc_lv J1[3]

#c# lv side 3.0V supply derivation
elec.connect Vcc_lv R4[1]
elec.connect Vstab  R4[2] D3[k] C5[1]
elec.connect Gnd_lv D3[a] C5[2]

#c# lv side switching of the isolator LED
elec.connect Vstab  R3[1]
elec.connect tnet1  R3[2] U1[a]
elec.connect tnet2  U1[k] Q3[d]
elec.connect tnet3  Q3[g] R5[2] R2[1] D2[k]
elec.connect Gnd_lv Q3[s]       R2[2] D2[a]

#c# lv side of the dcdc Converter
elec.connect Vcc_lv C1[1] C3[+] U2[+vin] U2[en]
elec.connect Gnd_lv C1[2] C3[-] U2[-vin]


#c# lv side of the dcdc Converter
elec.connect Vcc_hv C2[1] C4[+] U2[+vout]
elec.connect Gnd_hv C2[2] C4[-] U2[-vout]

#c# hv side MOSFET
elec.connect gn     Q1[g] Q2[g] TP1[1]
elec.connect gate   R1[1] D1[k] TP1[1] U3[out]
elec.connect Gnd_hv             R1[2] D1[a]

#c# hv side gate drive
elec.connect Vcc_hv U3[vdd] R6[1]
elec.connect Gnd_hv U3[gnd]       U1[e]
elec.connect sig_hv U3[inp] R6[2] U1[c]


$inter [set]= { U1, U2 }

$hvsys [set]= E@^hv / $inter
$lvsys [set]= E@^lv / $inter


phys.board N = 2 T = [ 1.6 ] W = [ 4, 4 ] M = ["FR4", "copper", "HASL" ]

phys.align [ Q1, Q2 ] axis = x d = 5m -vimp

phys.prox  $hvsys $lvsys min = 15m -ne
phys.creep $hvsys $lvsys   d = 15m -ne

$big_q [set]= { Q1, Q2 }
phys.layer *e / $big_q 0 -ne
phys.layer      $big_q 1 -ne

$high_I [set]= C@^I u { ( Q1[s] | Q2[s] ) }
phys.connectioncurrent $high_I 90 -vimp

phys.connmatch imp ( TP1[1] | { Q1[g], Q2[g] } ) -vimp #c# ensure gate drive symmetry.

phys.mkpcb

halt
