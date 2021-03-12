#!/usr/bin/env bash
echo $1 $2 $3

#Prepare for the test
echo 1 > /sys/block/sdc/trace/enable
echo 0 > /sys/kernel/debug/tracing/tracing_on
echo 0 > /sys/kernel/debug/tracing/events/enable

echo 10000 > /sys/kernel/debug/tracing/buffer_size_kb
echo blk > /sys/kernel/debug/tracing/current_tracer

echo 1 > /sys/kernel/debug/tracing/tracing_on

#Run the test case
if [ $3 = 'fsync' ]; then
	dd bs=$1 count=$2 if=/dev/zero of=/svn/$1_$2_$3.bin conv=fsync
else
	dd bs=$1 count=$2 if=/dev/zero of=/svn/$1_$2_$3.bin
fi

#Capture the test log
echo 0 > /sys/kernel/debug/tracing/tracing_on
echo 0 > /sys/block/sdc/trace/enable
cat /sys/kernel/debug/tracing/trace > test_$1_$2_$3.txt
echo nop > /sys/kernel/debug/tracing/current_tracer
echo > /sys/kernel/debug/tracing/trace
