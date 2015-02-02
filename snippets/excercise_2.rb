people = [{name: 'Mary', height: 160},
          {name: 'Isla', height: 80},
          {name: 'Sam'}]

height_total = 0
height_count = 0
people.each do |person|
  unless person[:height].nil?
    height_total += person[:height] 
    height_count += 1
  end
end

if height_count > 0
  average_height = height_total / height_count
end

p average_height
# => 120
