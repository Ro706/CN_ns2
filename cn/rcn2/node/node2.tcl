# Create a simulator object
set ns [new Simulator]

# Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

# Define a 'finish' procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exec nam out.nam &
    exit 0
}

# Create two nodes
set n0 [$ns node]
set n1 [$ns node]

# Create a link between the nodes
$ns duplex-link $n0 $n1 2Mb 10ms DropTail

# Set Queue Size of the link
$ns queue-limit $n0 $n1 10

# Define node positions (for NAM)
$ns duplex-link-op $n0 $n1 orient right

# Setup a TCP connection
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n1 $sink
$ns connect $tcp $sink

# Setup a FTP over TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

# Schedule the FTP start and stop times
$ns at 0.1 "$ftp start"
$ns at 4.0 "$ftp stop"

# Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

# Run the simulation
$ns run

