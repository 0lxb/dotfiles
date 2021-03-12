#!/bin/sh
echo $1

#Prepare for the test
echo 1 > /sys/block/$1/trace/enable
echo 0 > /sys/kernel/debug/tracing/tracing_on
echo 0 > /sys/kernel/debug/tracing/events/enable

echo 10000 > /sys/kernel/debug/tracing/buffer_size_kb
echo blk > /sys/kernel/debug/tracing/current_tracer

echo 1 > /sys/kernel/debug/tracing/tracing_on

#Run the test case
time ./sqlite-benchmark100

#Capture the test log
echo 0 > /sys/kernel/debug/tracing/tracing_on
echo 0 > /sys/block/$1/trace/enable
cat /sys/kernel/debug/tracing/trace > test_result.txt
echo nop > /sys/kernel/debug/tracing/current_tracer
echo > /sys/kernel/debug/tracing/trace
