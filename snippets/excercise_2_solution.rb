people = [{name: 'Mary', height: 160},
          {name: 'Isla', height: 80},
          {name: 'Sam'}]

heights = people.select {|p| not p[:height].nil?}.map {|p| p[:height]}
p heights.reduce(0) {|sum, height| sum += height/heights.length}
# => 120
