names = ['Mary', 'Isla', 'Sam']
names = names.map {|name| name.hash}

p names
# => [129073153, -674873862, 877987042]
# Good luck remembering those!

