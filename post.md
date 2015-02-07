
This is an unfunctional function:

    $a = 0
    def increment1
      $a += 1  
    end


This is a functional style function:

    def increment2(a)
      a + 1
    end

## Don't Iterate Over Lists ##

### Use Map, Reduce and Filter ###

### Map ###

Map takes a function and a collection of items. It makes a new, empty
collection, runs the function on each item in the original collection and
inserts each return value into the new collection. It returns the new
collection.

This is a simple map that takes a list of names and returns a list of the
lengths of those names:

    name_lengths = ["Mary", "Isla", "Sam"].map { |name| name.length }
    p name_lengths 
    # => [4, 4, 3]

    # Or, equivalently:
    # name_lengths = ["Mary", "Isla", "Sam"].collect { |name| name.length }

This is a map that squares every number in the passed collection:

    squares = [0, 1, 2, 3, 4].map {|e| e * e }
    p squares
    # => [0, 1, 4, 9, 16]

The unfunctional code below takes a list of real names and replaces them with randomly assigned code names.

    names = ['Mary', 'Isla', 'Sam']
    code_names = ['Mr. Pink', 'Mr. Orange', 'Mr. Blonde']

    names.each_index do |i|
      names[i] = code_names[rand(3)]
    end

    p names
    # => ["Mr. Blonde", "Mr. Pink", "Mr. Pink"]
