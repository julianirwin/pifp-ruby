time = 5
car_positions = [1, 1, 1]

while time > 0
  time -= 1
  print "\n"
  car_positions.each_index do |i|
    car_positions[i] += 1 if rand(10) > 3
    p '-' * car_positions[i]
  end
end

# Not bad!
