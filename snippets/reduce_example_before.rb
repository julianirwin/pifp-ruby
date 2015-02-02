sentences = ['Mary read a story to Sam and Isla.',
             'Isla cuddled Sam.',
             'Sam chortled.']

sam_count = 0
sentences.each do |sentence|
  sam_count += sentence.scan(/Sam/).count
end
p sam_count
