names = ['Mary', 'Isla', 'Sam']
code_names = ['Mr. Pink', 'Mr. Orange', 'Mr. Blonde']

names.each_index do |i|
  names[i] = code_names[rand(3)]
end

p names
# => ["Mr. Blonde", "Mr. Pink", "Mr. Pink"]

