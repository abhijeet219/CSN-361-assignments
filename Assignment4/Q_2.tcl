#Event Scheduler Object creation.

 set netSimInstance [new Simulator]

 #Creating trace objects and nam objects.

 
set namFile [open namOutput.nam w]
$netSimInstance namtrace-all $namFile

set traceFile [open traceOutput.tr w]
$netSimInstance trace-all $traceFile

 #Finish procedure
proc finish {}   {
    global netSimInstance traceFile namFile
    $netSimInstance flush-trace
    close $traceFile
    close $namFile
    exec nam namOutput.nam &
    exit 0
    #exec gawk -f Q2.awk traceOutput.tr &
}

 #Create the network
set node0 [$netSimInstance node]
set node1 [$netSimInstance node]
set node2 [$netSimInstance node]
set node3 [$netSimInstance node]
set node4 [$netSimInstance node]
set node5 [$netSimInstance node]

 #Creating Duplex-Link
$netSimInstance duplex-link $node0 $node2 .1Mb 10ms DropTail
$netSimInstance duplex-link $node2 $node1 .1Mb 10ms DropTail
$netSimInstance duplex-link $node2 $node3 .1Mb 10ms DropTail
$netSimInstance duplex-link $node3 $node4 .1Mb 10ms DropTail
$netSimInstance duplex-link $node3 $node5 .1Mb 10ms DropTail

 Agent/Ping instproc recv {from rtt} {
        $self instvar node_
        puts "node [$node_ id] received ping answer from \
              $from with round-trip-time $rtt ms."
}

set pingAgent0 [new Agent/Ping]
set pingAgent1 [new Agent/Ping]
set pingAgent2 [new Agent/Ping]
set pingAgent3 [new Agent/Ping]
set pingAgent4 [new Agent/Ping]
set pingAgent5 [new Agent/Ping]


$netSimInstance attach-agent $node0 $pingAgent0
$netSimInstance attach-agent $node1 $pingAgent1
$netSimInstance attach-agent $node2 $pingAgent2
$netSimInstance attach-agent $node3 $pingAgent3
$netSimInstance attach-agent $node4 $pingAgent4
$netSimInstance attach-agent $node5 $pingAgent5


$netSimInstance queue-limit $node0 $node2 2
$netSimInstance queue-limit $node2 $node1 2
$netSimInstance queue-limit $node2 $node3 2
$netSimInstance queue-limit $node3 $node4 1
$netSimInstance queue-limit $node3 $node5 1

$netSimInstance connect $pingAgent0 $pingAgent4
$netSimInstance connect $pingAgent5 $pingAgent1

$netSimInstance at 0.1 "$pingAgent0 send"
$netSimInstance at 0.2 "$pingAgent0 send"
$netSimInstance at 0.3 "$pingAgent0 send"
$netSimInstance at 0.4 "$pingAgent0 send"
$netSimInstance at 0.5 "$pingAgent0 send"
$netSimInstance at 0.6 "$pingAgent0 send"
$netSimInstance at 0.7 "$pingAgent0 send"
$netSimInstance at 0.8 "$pingAgent0 send"
$netSimInstance at 0.9 "$pingAgent0 send"
$netSimInstance at 1.0 "$pingAgent0 send"
$netSimInstance at 1.1 "$pingAgent0 send"
$netSimInstance at 1.2 "$pingAgent0 send"
$netSimInstance at 1.3 "$pingAgent0 send"
$netSimInstance at 1.4 "$pingAgent0 send"
$netSimInstance at 1.5 "$pingAgent0 send"
$netSimInstance at 1.6 "$pingAgent0 send"
$netSimInstance at 1.7 "$pingAgent0 send"
$netSimInstance at 1.8 "$pingAgent0 send"
$netSimInstance at 0.9 "$pingAgent0 send"
$netSimInstance at 2.0 "$pingAgent0 send"
$netSimInstance at 2.1 "$pingAgent0 send"
$netSimInstance at 2.2 "$pingAgent0 send"
$netSimInstance at 2.3 "$pingAgent0 send"
$netSimInstance at 2.4 "$pingAgent0 send"
$netSimInstance at 2.5 "$pingAgent0 send"
$netSimInstance at 2.6 "$pingAgent0 send"
$netSimInstance at 2.7 "$pingAgent0 send"
$netSimInstance at 2.8 "$pingAgent0 send"
$netSimInstance at 2.9 "$pingAgent0 send"

$netSimInstance at 0.1 "$pingAgent5 send"
$netSimInstance at 0.2 "$pingAgent5 send"
$netSimInstance at 0.3 "$pingAgent5 send"
$netSimInstance at 0.4 "$pingAgent5 send"
$netSimInstance at 0.5 "$pingAgent5 send"
$netSimInstance at 0.6 "$pingAgent5 send"
$netSimInstance at 0.7 "$pingAgent5 send"
$netSimInstance at 0.8 "$pingAgent5 send"
$netSimInstance at 0.9 "$pingAgent5 send"
$netSimInstance at 1.0 "$pingAgent5 send"
$netSimInstance at 1.1 "$pingAgent5 send"
$netSimInstance at 1.2 "$pingAgent5 send"
$netSimInstance at 1.3 "$pingAgent5 send"
$netSimInstance at 1.4 "$pingAgent5 send"
$netSimInstance at 1.5 "$pingAgent5 send"
$netSimInstance at 1.6 "$pingAgent5 send"
$netSimInstance at 1.7 "$pingAgent5 send"
$netSimInstance at 1.8 "$pingAgent5 send"
$netSimInstance at 0.9 "$pingAgent5 send"
$netSimInstance at 2.0 "$pingAgent5 send"
$netSimInstance at 2.1 "$pingAgent5 send"
$netSimInstance at 2.2 "$pingAgent5 send"
$netSimInstance at 2.3 "$pingAgent5 send"
$netSimInstance at 2.4 "$pingAgent5 send"
$netSimInstance at 2.5 "$pingAgent5 send"
$netSimInstance at 2.6 "$pingAgent5 send"
$netSimInstance at 2.7 "$pingAgent5 send"
$netSimInstance at 2.8 "$pingAgent5 send"
$netSimInstance at 2.9 "$pingAgent5 send"

$netSimInstance at 3.0 "finish"

 $netSimInstance run

#Command to know the number of packets dropped : gawk -f 2.awk traceOutput.tr