#c# This is a non inverting amplifier test board.
#c#deprecated.
$base_r [real]= 1k
$max_gain [int]= 5

$vr [real]= $base_r * ( $max_gain - 1 )
$rr [real]= $base_r

elec.part         "U1": opamp( type = "OP276" )                                  ; des = "main IC"                 ; fp = "Package_DIP:DIP-8_W7.62mm"
elec.part         "J1": pinheader( N = 8 )                                       ; des = "main io"                 ; fp = "TerminalBlock_CUI:TerminalBlock_CUI_TB007-508-08_1x08_P5.08mm_Horizontal"
elec.part         "R1": r( R = $rr, P = 0.25, type = "metal film" )              ; des = "fixed feedback resistor" ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part        "VR1": potentiometer( R = $vr, P = 0.1 )                        ; des = "gain adj"                ; fp = "Potentiometer_SMD:Potentiometer_ACP_CA6-VSMD_Vertical"
elec.part ["C1", "C2"]: nonpol_c( C = 100n, V = 35, type = "ceramic" )           ; des = "PSU filtering"           ; fp = "Capacitor_SMD:C_0805_2012Metric"
elec.part ["C3", "C4"]: pol_c( C = 47u, V = 35, type = "aluminium electrolyte" ) ; des = "PSU filtering"           ; fp = "Capacitor_SMD:CP_Elec_8x6.9"

elec.net "V+"
elec.net "V-"
elec.net "GND"
elec.net "Vin"
elec.net "Vout"
elec.net "Vfb"

elec.connect GND  J1[2] J1[4] J1[7]  J1[8] C1[2] C2[2] R1[2] C3[-] C4[+]
elec.connect V+   J1[5] C1[1] U1[v+] C3[+]
elec.connect V-   J1[6] C2[1] U1[v-] C4[-]
elec.connect Vin  J1[1] U1[+]
elec.connect Vout J1[3] U1[out] VR1[end1]
elec.connect Vfb  U1[-] R1[1]   VR1[end2] VR1[wiper]

$cerc [set]= { C1, C2 }
$inp  [set]= I@Vin
$ninp [set]= *e / { I@Vin, J1, U1 }

phys.prox $cerc U1 max = 4m -vimp

phys.prox $inp $ninp min = 2m -ne

phys.side *p T -oeo

halt
