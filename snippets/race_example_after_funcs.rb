$time = 5
$car_positions = [1, 1, 1]

def run_step_of_race
  $time -= 1
  move_cars()
end

def move_cars
  $car_positions.each_index do |i|
    $car_positions[i] += 1 if rand(10) > 3
  end
end

def draw
  print "\n"
  $car_positions.each do |position|
    draw_car(position)
  end
end

def draw_car(position)
  p '-' * position
end

while $time > 0 do
  run_step_of_race()
  draw()
end


