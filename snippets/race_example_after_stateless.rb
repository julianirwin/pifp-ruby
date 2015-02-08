def draw(state)
  print "\n"
  state[:car_positions].each do |pos| 
    p '-' * pos
  end
end

def run_step_of_race(state)
  state[:time] -= 1
  state[:car_positions] = state[:car_positions].map do |pos|
    rand(10) > 3 ? pos += 1 : pos
  end
  return state
end

def race(state)
  draw(state)
  race run_step_of_race(state) if state[:time] > 0
end

race time: 5, car_positions: [1, 1, 1]

# Betters!
