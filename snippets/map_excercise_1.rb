names = ['Mary', 'Isla', 'Sam']
code_names = ['Mr. Pink', 'Mr. Orange', 'Mr. Blonde']

names.each_index do |i|
  names[i] = names[i].hash
end

p names
# => [129073153, -674873862, 877987042]
# Good luck remembering those!

