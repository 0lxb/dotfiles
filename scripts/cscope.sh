#!/bin/sh
find . -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.lds" -o -name "*.go" -o -name "*.s" -o -name "*.S" -o -name "*.mk"> cscope.files
cscope -bkq -i cscope.files
ctags -R
