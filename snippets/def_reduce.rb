sum = (0..4).reduce {|a, x| a += x }
# => 10

# Alias:              (0..4).inject {|a, x| a += x }
# Initial value:      (0..4).reduce(2) {|a, x| a += x}
# Alternative syntax: (0..4).inject(2, func)  # func -> f(a, x)
p sum
