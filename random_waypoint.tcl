# Define Simulator
set ns [new Simulator]

# Set up the wireless channel
set val(chan) Channel/WirelessChannel
set val(prop) Propagation/TwoRayGround
set val(netif) Phy/WirelessPhy
set val(mac) Mac/802_11
set val(ifq) Queue/DropTail/PriQueue
set val(ll) LL
set val(ant) Antenna/OmniAntenna
set val(ifqlen) 50
set val(nn) 10         ;# Number of mobile nodes
set val(x) 500         ;# X dimension of topology
set val(y) 500         ;# Y dimension of topology

# Topography
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

# Node Configuration
$ns node-config -adhocRouting AODV \
                -llType $val(ll) \
                -macType $val(mac) \
                -ifqType $val(ifq) \
                -ifqLen $val(ifqlen) \
                -antType $val(ant) \
                -propType $val(prop) \
                -phyType $val(netif) \
                -channelType $val(chan) \
                -topoInstance $topo \
                -agentTrace ON \
                -routerTrace ON \
                -macTrace OFF

# Create nodes
for {set i 0} {$i < $val(nn)} {incr i} {
    set node_($i) [$ns node]
    $node_($i) random-motion 0
}

# Define Random Waypoint Mobility Model
proc set_random_waypoint {} {
    global ns val
    for {set i 0} {$i < $val(nn)} {incr i} {
        set xpos [expr rand()*$val(x)]
        set ypos [expr rand()*$val(y)]
        set speed [expr 5.0 + rand()*10.0]
        $ns at 0.0 "$node_($i) setdest $xpos $ypos $speed"
    }
}

# Apply the Random Waypoint Model
set_random_waypoint

# End Simulation
$ns at 100.0 "finish"
proc finish {} {
    global ns
    $ns flush-trace
    exit 0
}

# Run Simulation
$ns run
