names = ['Mary', 'Isla', 'Sam']
code_names = ['Mr. Pink', 'Mr. Orange', 'Mr. Blonde']

names = names.map {|name| code_names[rand(3)]}

p names
# => ["Mr. Blonde", "Mr. Pink", "Mr. Pink"]

