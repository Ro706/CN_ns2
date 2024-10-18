
set a 10;
set b [expr $a == 1 ? 20: 30]
puts "Value of b is $b\n"
set b [expr $a == 10 ? 20: 30]
puts "Value of b is $b\n"

set num 10

if {$num > 5} {
    puts "The number is greater than 5."
} else {
    puts "The number is 5 or less."
}

