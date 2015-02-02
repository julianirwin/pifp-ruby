sentences = ['Mary read a story to Sam and Isla.',
             'Isla cuddled Sam.',
             'Sam chortled.']

sam_count = sentences.reduce(0) { |c, s| c += s.scan(/Sam/).count }
p sam_count
