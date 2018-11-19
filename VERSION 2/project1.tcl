#Create a simulator object
set ns [new Simulator]

#Tell the simulator to use dynamic routing
$ns rtproto DV

#Create a trace file
set tracefd [open project1.tr w]
$ns trace-all $tracefd

#Create 18 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]
set n15 [$ns node]
set n16 [$ns node]
set n17 [$ns node]

#Create a duplex link between the nodes
$ns duplex-link $n8 $n0 1Mb 20ms DropTail
$ns duplex-link $n9 $n1 1Mb 20ms DropTail
$ns duplex-link $n0 $n2 2Mb 40ms DropTail
$ns duplex-link $n1 $n2 2Mb 40ms DropTail
$ns duplex-link $n2 $n3 8Mb 100ms DropTail
$ns duplex-link $n2 $n4 8Mb 100ms DropTail
$ns duplex-link $n3 $n4 8Mb 100ms DropTail
$ns duplex-link $n3 $n5 2Mb 40ms DropTail
$ns duplex-link $n4 $n6 2Mb 40ms DropTail
$ns duplex-link $n4 $n7 2Mb 40ms DropTail
$ns duplex-link $n5 $n10 1Mb 20ms DropTail
$ns duplex-link $n5 $n11 1Mb 20ms DropTail
$ns duplex-link $n5 $n12 1Mb 20ms DropTail
$ns duplex-link $n5 $n13 1Mb 20ms DropTail
$ns duplex-link $n6 $n14 1Mb 20ms DropTail
$ns duplex-link $n6 $n15 1Mb 20ms DropTail
$ns duplex-link $n7 $n16 1Mb 20ms DropTail
$ns duplex-link $n7 $n17 1Mb 20ms DropTail

#Set Queue Size of links
$ns queue-limit $n8 $n0 20^M
$ns queue-limit $n9 $n1 20^M
$ns queue-limit $n0 $n2 25^M
$ns queue-limit $n1 $n2 25^M
$ns queue-limit $n2 $n3 30^M
$ns queue-limit $n2 $n4 30^M
$ns queue-limit $n3 $n4 30^M
$ns queue-limit $n3 $n5 25^M
$ns queue-limit $n4 $n6 25^M
$ns queue-limit $n4 $n7 25^M
$ns queue-limit $n5 $n10 20^M
$ns queue-limit $n5 $n11 20^M
$ns queue-limit $n5 $n12 20^M
$ns queue-limit $n5 $n13 20^M
$ns queue-limit $n6 $n14 20^M
$ns queue-limit $n6 $n15 20^M
$ns queue-limit $n7 $n16 20^M
$ns queue-limit $n7 $n17 20^M

#Create a TCP and UDP agent for each traffic source and attach it to proper nodes
set udp_12 [new Agent/UDP]
$ns attach-agent $n9 $udp_12
set udp_13 [new Agent/UDP]
$ns attach-agent $n9 $udp_13
set udp_15 [new Agent/UDP]
$ns attach-agent $n9 $udp_15
set udp_17 [new Agent/UDP]
$ns attach-agent $n9 $udp_17
set tcp_10 [new Agent/TCP]
$tcp_10 set class_ 2
$ns attach-agent $n8 $tcp_10
set tcp_11 [new Agent/TCP]
$tcp_11 set class_ 2
$ns attach-agent $n8 $tcp_11
set tcp_14 [new Agent/TCP]
$tcp_14 set class_ 2
$ns attach-agent $n8 $tcp_14
set tcp_16 [new Agent/TCP]
$tcp_16 set class_ 2
$ns attach-agent $n8 $tcp_16

#Set flow id for each traffic
$tcp_10 set fid_ 10^M
$tcp_11 set fid_ 11^M
$udp_12 set fid_ 12^M
$udp_13 set fid_ 13^M
$tcp_14 set fid_ 14^M
$udp_15 set fid_ 15^M
$tcp_16 set fid_ 16^M
$udp_17 set fid_ 17^M

#Create a CBR generator for each traffic source and attach it to its agent
set cbr10 [new Application/Traffic/CBR]
$cbr10 set packetSize_ 1000
$cbr10 set interval_ 0.005
$cbr10 set random_ 1
$cbr10 attach-agent $tcp_10

set cbr11 [new Application/Traffic/CBR]
$cbr11 set packetSize_ 3000
$cbr11 set interval_ 0.005
$cbr11 set random_ 1
$cbr11 attach-agent $tcp_11

set cbr12 [new Application/Traffic/CBR]
$cbr12 set packetSize_ 1000
$cbr12 set interval_ 0.005
$cbr12 set random_ 1
$cbr12 attach-agent $udp_12

set cbr13 [new Application/Traffic/CBR]
$cbr13 set packetSize_ 3000
$cbr13 set interval_ 0.005
$cbr13 set random_ 1
$cbr13 attach-agent $udp_13

set cbr14 [new Application/Traffic/CBR]
$cbr14 set packetSize_ 2000
$cbr14 set interval_ 0.005
$cbr14 set random_ 1
$cbr14 attach-agent $tcp_14

set cbr15 [new Application/Traffic/CBR]
$cbr15 set packetSize_ 2000
$cbr15 set interval_ 0.005
$cbr15 set random_ 1
$cbr15 attach-agent $udp_15

set cbr16 [new Application/Traffic/CBR]
$cbr16 set packetSize_ 2000
$cbr16 set interval_ 0.005
$cbr16 set random_ 1
$cbr16 attach-agent $tcp_16

set cbr17 [new Application/Traffic/CBR]
$cbr17 set packetSize_ 2000
$cbr17 set interval_ 0.005
$cbr17 set random_ 1
$cbr17 attach-agent $udp_17

#Create a LossMonitor agent for each traffic and attach it to end nodes

set sink10 [new Agent/TCPSink]
$ns attach-agent $n10 $sink10
set sink11 [new Agent/TCPSink]
$ns attach-agent $n11 $sink11
set sink12 [new Agent/LossMonitor]
$ns attach-agent $n12 $sink12
set sink13 [new Agent/LossMonitor]
$ns attach-agent $n13 $sink13
set sink14 [new Agent/TCPSink]
$ns attach-agent $n14 $sink14
set sink15 [new Agent/LossMonitor]
$ns attach-agent $n15 $sink15
set sink16 [new Agent/TCPSink]
$ns attach-agent $n16 $sink16
set sink17 [new Agent/LossMonitor]
$ns attach-agent $n17 $sink17

#Connect the traffic sources to the traffic sinks
$ns connect $tcp_10 $sink10
$ns connect $tcp_11 $sink11
$ns connect $udp_12 $sink12
$ns connect $udp_13 $sink13
$ns connect $tcp_14 $sink14
$ns connect $udp_15 $sink15
$ns connect $tcp_16 $sink16
$ns connect $udp_17 $sink17

#Shedule events for the CBR agent
$ns at 1 "$cbr10 start"
$ns at 1 "$cbr11 start"
$ns at 1 "$cbr14 start"
$ns at 1 "$cbr16 start"
$ns at 2 "$cbr12 start"
$ns at 2 "$cbr13 start"
$ns at 2 "$cbr15 start"
$ns at 2 "$cbr17 start"
$ns rtmodel-at 6 down $n2 $n3
$ns rtmodel-at 7 up $n2 $n3
$ns at 10 "$cbr10 stop"
$ns at 10 "$cbr11 stop"
$ns at 10 "$cbr12 stop"
$ns at 10 "$cbr13 stop"
$ns at 10 "$cbr14 stop"
$ns at 10 "$cbr15 stop"
$ns at 10 "$cbr16 stop"
$ns at 10 "$cbr17 stop"
$ns at 10 "exit 0"

#Run the simulation
$ns run