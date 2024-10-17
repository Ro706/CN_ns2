# Initialize the NS-2 simulator
set ns [new Simulator]

# Set simulation parameters
set val(chan) Channel/WirelessChannel
set val(prop) Propagation/TwoRayGround
set val(netif) Phy/WirelessPhy
set val(mac) Mac/802_11
set val(ifq) Queue/DropTail/PriQueue
set val(ll) LL
set val(ant) Antenna/OmniAntenna
set val(ifqlen) 50
set val(nn) 10          ;# Number of mobile nodes
set val(x) 500          ;# X dimension of topology
set val(y) 500          ;# Y dimension of topology

# Create trace file for output
set tracefile [open out.tr w]
$ns trace-all $tracefile

# Create topography object
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

# Configure nodes with the wireless channel
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

# Create the God instance
if {[info commands God] eq ""} {
    puts "Warning: God instance is not available. Ensure that NS-2 is properly configured."
} else {
    set god_ [God instance]
}

# Check if God instance is created
if {![info exists god_]} {
    puts "Error: Cannot find instance of God."
    exit 1
}

# Create mobile nodes and register them with God
for {set i 0} {$i < $val(nn)} {incr i} {
    set node_($i) [$ns node]
    $node_($i) random-motion 0
    $god_ new-node $node_($i)  ;# Register node with God
}

# Define Random Walk Mobility Model
proc set_random_walk {} {
    global ns val node_
    for {set i 0} {$i < $val(nn)} {incr i} {
        set xpos [expr rand()*$val(x)]
        set ypos [expr rand()*$val(y)]
        set speed [expr 5.0 + rand()*5.0]
        $ns at 0.0 "$node_($i) setdest $xpos $ypos $speed"
    }
}

# Set mobility model for nodes
set_random_walk

# Procedure to end simulation
proc finish {} {
    global ns tracefile
    $ns flush-trace
    close $tracefile
    exit 0
}

# Schedule the end of the simulation
$ns at 100.0 "finish"

# Start the simulation
$ns run
