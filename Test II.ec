# some test circuit for parametric design.

$n [int]= 8   # LED count
$v [real]= 5.0 # input voltage
$i [real]= 10m # forward current
$color [string]= "red" # red / green / blue




$colors [list]= ["red", "green", "blue"]

if $color !E $colors::{print("enter a valid color!")%N halt}

for $idx E [0:1:2] ::{
if $color == $colors[$idx]::{
$vf [real]= [ 1.9, 2.5, 3.2 ][$idx]
}
}

$r [real]= ( $v - $vf ) / $i

elec.part "J1": pinheader( N = 2 ) ; des = "main io"; fp = "TerminalBlock_CUI:TerminalBlock_CUI_TB007-508-02_1x02_P5.08mm_Horizontal"

elec.net "Gnd"
elec.net "Vcc"

elec.connect Gnd J1[1]
elec.connect Vcc J1[2]

for $P E [1:1:$n]::{
$D [string]= str("D", $P )
$R [string]= str("R", $P )
elec.part $R: r( R = $r, P = 0.25, type = "metal film" ) ; des = "current limiting resistor" ; fp = "Resistor_SMD:R_0805_2012Metric"
elec.part $D: led( color = $color, I = $i )              ; des = "LED"                       ; fp = "LED_THT:LED_D5.0mm"

elec.connect Gnd ref($R)[2]
elec.connect Vcc ref($D)[a]
elec.connect ref($D)[k] ref($R)[1]
}

halt
