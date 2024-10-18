#!/usr/bin/tclsh

set myVariable 18
puts $myVariable
puts [expr $myVariable + 6 + 9]

set myVar hello
puts $myVar

set myVariable "hello world"
puts $myVariable

set myVariable {hello world}
puts $myVariable

set myVariable {red green blue}
puts [lindex $myVariable 2]
set myVariable "red green blue"
puts [lindex $myVariable 1]


set  marks(english) 80
puts $marks(english)
set  marks(mathematics) 90
puts $marks(mathematics)

set myfile [open "ro.txt" r]
puts $myfile
