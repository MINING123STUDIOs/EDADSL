# some test circuit for parametric design.

$n V= 8   # LED count
$v V= 5.0 # input voltage
$i V= 10m # forward current
$color W= "red" # red / green / blue




$colors L= ["red", "green", "blue"]

if $color !E $colors::{print("enter a valid color!")%N halt}

for $idx E [0:1:2] ::{
if $color == $colors[$idx]::{
$vf V= [ 1.9, 2.5, 3.2 ][$idx]
}
}

$r V= ( $v - $vf ) / $i

part "J1": pinheader( N = 2 ) ; des = "main io"; fp = "TerminalBlock_CUI:TerminalBlock_CUI_TB007-508-02_1x02_P5.08mm_Horizontal"

net "Gnd"
net "Vcc"

connect Gnd J1[1]
connect Vcc J1[2]

for $P E [1:1:$n]::{
$D W= str("D", $P )
$R W= str("R", $P )
part $R: r( R = $r, P = 0.25, type = "metal film" ) ; des = "current limiting resistor" ; fp = "Resistor_SMD:R_0805_2012Metric"
part $D: led( color = $color, I = $i )              ; des = "LED"                       ; fp = "LED_THT:LED_D5.0mm"

connect Gnd ref($R)[2]
connect Vcc ref($D)[a]
connect ref($D)[k] ref($R)[1]
}

halt
