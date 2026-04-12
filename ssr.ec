# high power high current AC and DC solid state relay module. 80A 1kV

#part "": (); des = ""; fp = ""
#    refrence              part model                                                  part description                                                                                                                           footprint
part       [ "Q1", "Q2" ]: mosfet( type = "C2M0025120D" )                            ; des = "90A Id, 1200V Vds, 25mOhm, N-Channel SiC MOSFET, TO-247"                                                                          ; fp = "Package_TO_SOT_THT:TO-247-3_Horizontal_TabUp"
part               "U1"  : isolator( type = "SFH617A-1" )                            ; des = "Optocoupler, Phototransistor Output, 5300 VRMS, VCEO 70V, CTR% 40-80, -55 to +110 degree Celsius, UL, BSI, FIMKO, cUL, THT PDIP-4"; fp = "Package_DIP:DIP-4_W10.16mm"
part               "U2"  : dcdc_converter( type = "ATA00C18S-L" )                    ; des = "Artesyn 3W Isolated DC/DC Converter Module, 15V Output Voltage, 9-36V Input Voltage, 1.5kV insolation"                            ; fp = "Converter_DCDC:Converter_DCDC_Artesyn_ATA_SMD"
part               "U3"  : gate_driver( type = "TC4422" )                            ; des = "9A High-Speed non-inverting MOSFET Driver"                                                                                        ; fp = "Package_DIP:DIP-8_W7.62mm"
part [ "R1", "R2", "R6" ]: r( R = 10k, P = 0.25, type = "carbon" )                   ; des = "gate bleed resistor"                                                                                                              ; fp = "Resistor_SMD:R_0805_2012Metric"
part               "R3"  : r( R = 470, P = 0.25, type = "carbon" )                   ; des = "current limiting resistor for the optoisolator LED"                                                                               ; fp = "Resistor_SMD:R_0805_2012Metric"
part       [ "R4", "R5" ]: r( R = 100, P = 0.25, type = "carbon" )                   ; des = "current limiting resistor for the stabilized 3.0V supply"                                                                         ; fp = "Resistor_SMD:R_0805_2012Metric"
part       [ "H1", "H2" ]: hole( size = "M6" )                                       ; des = "high current connection points"                                                                                                   ; fp = "MountingHole:MountingHole_6.4mm_M6_Pad_Via"
part       [ "D1", "D2" ]: zener( type = "BZV55B20" )                                ; des = " 20V, 500mW, 2%, Zener diode, MiniMELF"                                                                                           ; fp = "Diode_SMD:D_MiniMELF"
part               "D3"  : zener( type = "BZV55B3V0" )                               ; des = "3.0V, 500mW, 2%, Zener diode, MiniMELF"                                                                                           ; fp = "Diode_SMD:D_MiniMELF"
part [ "C1", "C2", "C5" ]: nonpol_c( C = 100n, V = 35, type = "ceramic" )            ; des = "PSU filtering"                                                                                                                    ; fp = "Capacitor_SMD:C_0805_2012Metric"
part       [ "C3", "C4" ]: pol_c( C = 470u, V = 35, type = "aluminium electrolyte" ) ; des = "PSU filtering"                                                                                                                    ; fp = "Capacitor_SMD:CP_Elec_8x6.9"
part               "J1"  : pinheader( N = 3 )                                        ; des = "main lv side io"                                                                                                                  ; fp = "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical"
part               "Q3"  : mosfet( type = "2N7002H" )                                ; des = "0.21A Id, 60V Vds, N-Channel MOSFET, SOT-23"                                                                                      ; fp = "Package_TO_SOT_SMD:SOT-23"
part              "TP1"  : testpoint( )                                              ; des = "node"                                                                                                                             ; fp = "TestPoint:TestPoint_Pad_1.0x1.0mm"


net "Vswa"   "hv" "I"
net "Vswb"   "hv" "I"

net "Gnd_hv" "hv"
net "Vcc_hv" "hv"
net "sig_hv" "hv"
net "gate"   "hv"
net "gn"     "hv"

net "Gnd_lv" "lv"
net "Vcc_lv" "lv"
net "sig_lv" "lv"
net "Vstab"  "lv"

net "tnet1"  "lv"
net "tnet2"  "lv"
net "tnet3"  "lv"

# IO connections
connect Vswa   H1[1] Q1[d]
connect Vswb   H2[1] Q2[d]
connect Gnd_hv Q1[s] Q2[s]

connect Gnd_lv J1[1]
connect sig_lv J1[1] R5[1]
connect Vcc_lv J1[3]

# lv side 3.0V supply derivation
connect Vcc_lv R4[1]
connect Vstab  R4[2] D3[k] C5[1]
connect Gnd_lv D3[a] C5[2]

# lv side switching of the isolator LED
connect Vstab  R3[1]
connect tnet1  R3[2] U1[a]
connect tnet2  U1[k] Q3[d]
connect tnet3  Q3[g] R5[2] R2[1] D2[k]
connect Gnd_lv Q3[s]       R2[2] D2[a]

# lv side of the dcdc Converter
connect Vcc_lv C1[1] C3[+] U2[+vin] U2[en]
connect Gnd_lv C1[2] C3[-] U2[-vin]


# lv side of the dcdc Converter
connect Vcc_hv C2[1] C4[+] U2[+vout]
connect Gnd_hv C2[2] C4[-] U2[-vout]

# hv side MOSFET
connect gn     Q1[g] Q2[g] TP1[1]
connect gate   R1[1] D1[k] TP1[1] U3[out]
connect Gnd_hv             R1[2] D1[a]

# hv side gate drive
connect Vcc_hv U3[vdd] R6[1]
connect Gnd_hv U3[gnd]       U1[e]
connect sig_hv U3[inp] R6[2] U1[c]


$inter S= { U1, U2 }

$hvsys S= E@^hv / $inter
$lvsys S= E@^lv / $inter


phy.board N = 2 T = [ 1.6 ] W = [ 4, 4 ] M = ["FR4", "copper", "HASL" ]

phy.align [ Q1, Q2 ] axis = x d = 5 -vimp

phy.prox  $hvsys $lvsys min = 15 -ne
phy.creep $hvsys $lvsys       15 -ne

$big_q S= { Q1, Q2 }
phy.layer *e / $big_q 0 -ne
phy.layer      $big_q 1 -ne

$high_I S= C@^I u { ( Q1[s] | Q2[s] ) }
phy.connectioncurrent $high_I 90 -vimp

phy.connmatch imp ( TP1[1] | { Q1[g], Q2[g] } ) -vimp # ensure gate drive symmetry.

mkpcb

halt
