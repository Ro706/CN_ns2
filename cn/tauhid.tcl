# 1. Initialize the simulator
set ns [new Simulator]

# 2. Open trace and NAM files
set tracefile [open out.tr w]
set namfile [open out.nam w]
$ns trace-all $tracefile
$ns namtrace-all $namfile

# 3. Create two nodes
set node1 [$ns node]
set node2 [$ns node]

# 4. Create a duplex link between the nodes
$ns duplex-link $node1 $node2 1Mb 10ms DropTail

# 5. Create a UDP agent and attach it to node1
set udp [new Agent/UDP]
$ns attach-agent $node1 $udp

# 6. Create a Null agent and attach it to node2 (UDP sink)
set null [new Agent/Null]
$ns attach-agent $node2 $null

# 7. Connect the UDP agent to the Null agent
$ns connect $udp $null

# 8. Create a CBR traffic generator and attach it to the UDP agent
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

# 9. Set CBR parameters (packet size and rate)
$cbr set packetSize_ 500
$cbr set rate_ 1Mb

# 10. Schedule CBR traffic to start at 0.5 seconds
$ns at 0.5 "$cbr start"
$ns at 1.5 "$cbr stop"

# Schedule the simulation to end at 2.0 seconds
$ns at 2.0 "finish"

# Define a 'finish' procedure to close the trace and NAM files
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}

# Run the simulation
$ns run
