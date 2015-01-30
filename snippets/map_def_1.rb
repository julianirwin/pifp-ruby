name_lengths = ["Mary", "Isla", "Sam"].map { |name| name.length }
# Or, equivalently:
# name_lengths = ["Mary", "Isla", "Sam"].collect { |name| name.length }
p name_lengths 
# => [4, 4, 3]

