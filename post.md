The following is an [article written by Mary Rose Cook][http://maryrosecook.com/blog/post/a-practical-introduction-to-functional-programming].
My only contributions were the translation of the Python examples into Ruby
and slight changes to the text.

### A Guide Rope ###

Functional code is characterised by one thing: the absence of side effects. It
doesn’t rely on data outside the current function, and it doesn’t change data
that exists outside the current function. Every other “functional” thing can be
derived from this property. Use it as a guide rope as you learn.

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

This is a map that squares every number in the passed collection:

    squares = [0, 1, 2, 3, 4].map {|e| e * e }
    p squares
    # => [0, 1, 4, 9, 16]

The unfunctional code below takes a list of real names and replaces them with
randomly assigned code names.

    names = ['Mary', 'Isla', 'Sam']
    code_names = ['Mr. Pink', 'Mr. Orange', 'Mr. Blonde']

    names.each_index do |i|
      names[i] = code_names[rand(3)]
    end

    p names
    # => ["Mr. Blonde", "Mr. Pink", "Mr. Pink"]

This can be rewritten as a map:

    names = ['Mary', 'Isla', 'Sam']
    code_names = ['Mr. Pink', 'Mr. Orange', 'Mr. Blonde']
    
    names = names.map {|name| code_names[rand(3)]}
    
    p names
    # => ["Mr. Blonde", "Mr. Pink", "Mr. Pink"]

**Excercise 1.** Try rewriting the code below as a map. It takes a list of real
names and replaces them with code names produced using a more robust strategy.


    names = ['Mary', 'Isla', 'Sam']
    code_names = ['Mr. Pink', 'Mr. Orange', 'Mr. Blonde']
    
    names.each_index do |i|
      names[i] = names[i].hash
    end
    
    p names
    # => [129073153, -674873862, 877987042]
    # Good luck remembering those!

**A Solution:**

    names = names.map {|name| name.hash}
    p names
    # => [129073153, -674873862, 877987042]
    # Good luck remembering those!

### Reduce ###

Reduce takes a function and a collection of items. It returns a value that is
created by combining the items.

This is a simple reduce. It returns the sum of all the items in the collection.

    sum = (0..4).reduce {|a, x| a += x }
    # => 10
    
    # Initial value:      (0..4).reduce(2) {|a, x| a += x}
    p sum

Reduce takes a block of code with two arguments: `x` is the current element 
of the array, and 'a' is called the accumulator. The value of `a` is the 
return value of the block of code that ran on the previous element of the 
array. 

What is `a` the when the block is run for the first element in the array?
That depends. In most implementations the default is for `a` to initialize
to the first element in the array. The initial value can also be set by
passing an optional parameter to reduce.

This code counts how often the word 'Sam' appears in a list of strings:

    sentences = ['Mary read a story to Sam and Isla.',
                 'Isla cuddled Sam.',
                 'Sam chortled.']

    sam_count = 0
    sentences.each do |sentence|
      sam_count += sentence.scan(/Sam/).count
    end
    p sam_count
    # => 3

This is the same code written as a reduce:

    sam_count = sentences.reduce(0) { |c, s| c += s.scan(/Sam/).count }
    p sam_count
    # => 3

Why Are Map and Reduce Better? 
- They are often one-liners
- The important parts of the iteration – the collection, the operation and the
  return value – are always in the same places in every map and reduce.
- The code in a loop may affect variables defined before it or code that runs
  after it. By convention, maps and reduces are functional.
- map and reduce are elemental operations. Every time a person reads a `for`
  loop, they have to work through the logic line by line. There are few
  structural regularities they can use to create a scaffolding on which to hang
  their understanding of the code. In contrast, map and reduce are at once
  building blocks that can be combined into complex algorithms, and elements
  that the code reader can instantly understand and abstract in their mind.
  “Ah, this code is transforming each item in this collection. It’s throwing
  some of the transformations away. It’s combining the remainder into a single
  output.”
- Map and reduce have many friends that provide useful, tweaked versions of
  their basic behaviour. For example: `filter`, `all`, `any` and `find`.

**Excercise 2.** Try rewriting the code below using map, reduce and filter.
Filter takes a function and a collection. It returns a collection of every item
for which the function returned True.

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

If this seems tricky, try not thinking about the operations on the data. Think
of the states the data will go through, from the list of people dictionaries to
the average height. 

Don’t try and bundle multiple transformations together. Put each on a separate
line and assign the result to a descriptively-named variable. Once the code
works, condense it.

**My Solution:**

    people = [{name: 'Mary', height: 160},
              {name: 'Isla', height: 80},
              {name: 'Sam'}]
    
    heights = people.select {|p| not p[:height].nil?}.map {|p| p[:height]}
    p heights.reduce(0) {|sum, height| sum += height/heights.length}
    # => 120

### Write Declaratively, Not Imperatively ###

The program below runs a race between three cars. At each time step, each car
may move forwards or it may stall. At each time step, the program prints out
the paths of the cars so far. After five time steps, the race is over.

This is some sample output:

    -
    --
    --

    --
    --
    ---

    ---
    --
    ---

    ----
    ---
    ----

    ----
    ----
    -----

This is the program:


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

This example is going to be functionalized in steps.

### Use Functions ###

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


To understand this program, the reader just reads the main loop. “If there is
time left, run a step of the race and draw. Check the time again.” If the
reader wants to understand more about what it means to run a step of the race,
or draw, they can read the code in those functions.

There are no comments any more. The code describes itself.

Splitting code into functions is a great, low brain power way to make code more
readable.

This technique uses functions, but it uses them as sub-routines. They parcel up
code. The code is not functional in the sense of the guide rope. The functions
in the code use state that was not passed as arguments. They affect the code
around them by changing external variables, rather than by returning values. To
check what a function really does, the reader must read each line carefully. If
they find an external variable, they must find its origin. They must see what
other functions change that variable.

### Remove State ###

This is a functional version of the car code:

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
    
    # Better!

The code is still split into functions, but the functions are functional. There
are three signs of this. First, there are no longer any shared variables.
`time` and `car_positions` get passed straight into `race()`. Second, functions
take parameters. Third, no variables are instantiated inside functions. All
data changes are done with return values. `race()` recurses with the result of
`run_step_of_race()`. Each time a step generates a new state, it is passed
immediately into the next step.

Now, here are two functions, `zero()` and `one()`:

    def zero(s)
      if s[0] == "0"
        s[1..-1]
      end
    end

    def one(s)
      if s[0] == "1"
        s[1..-1]
      end
    end


`zero()` takes a string, `s`. If the first character is `'0'`, it returns the
rest of the string. If it is not, it returns `nil`, the default return value of
Ruby functions. `one()` does the same, but for a first character of `'1'`.

Imagine a function called `rule_sequence()`. It takes a string and a list of rule
functions of the form of `zero()` and `one()`. It calls the first rule on the
string. Unless `nil` is returned, it takes the return value and calls the second
rule on it. Unless `nil` is returned, it takes the return value and calls the
third rule on it. And so forth. If any rule returns `nil`, `rule_sequence()` stops
and returns `nil`. Otherwise, it returns the return value of the final rule.

This is some sample input and output:

    p rule_sequence("0101", [zero, one, zero])
    # => 1
    
    p rule_sequence("0101", [zero, zero])
    # => nil

This is the imperative version of `rule_sequence()`.

    def rule_sequence(s, rules)
      rules.each do |rule|
        s = rule[s]
        break if s.nil?
      end
      return s
    end

**Exercise 3**. The code above uses a loop to do its work. Make it more
declarative by rewriting it as a recursion.

**My solution:**

    def rule_sequence(s, rules)
      return s if s.nil? or rules.empty?
      rule_sequence(rules[0][s], rules[1..-1]) 
    end
    
    # There MUST be a ruby way to do this functionally. This way is crap.
    zero = method :zero
    one = method :one

### Use Pipelines ###

In the previous section, some imperative loops were rewritten as recursions
that called out to auxiliary functions. In this section, a different type of
imperative loop will be rewritten using a technique called a pipeline.

The loop below performs transformations on dictionaries that hold the name,
incorrect country of origin and active status of some bands.


    bands = [ {name: 'sunset rubdown', country: 'UK', active: false},
              {name: 'women', country: 'Germany', active: false},
              {name: 'a silver mt. zion', country: 'Spain', active: true} ]
    
    def format_bands(bands)
      bands.each do |band|
        band[:country] = 'Canada'
        band[:name] = band[:name].delete('.')
        band[:name] = band[:name].upcase
      end
    end
    
    p format_bands(bands)
    # => [{:name=>"SUNSET RUBDOWN", :country=>"Canada", :active=>false}, 
    #     {:name=>"WOMEN", :country=>"Canada", :active=>false}, 
    #     {:name=>"A SILVER MT ZION", :country=>"Canada", :active=>true}]
    #
    #     ...looks..fine...but can it be improved? Yes!

Worries are stirred by the name of the function: “format” is very vague. Upon
closer inspection of the code, these worries begin to claw. Three things happen
in the same loop. The 'country' key gets set to 'Canada'. Punctuation is
removed from the band name. The band name gets capitalized. It is hard to tell
what the code is intended to do and hard to tell if it does what it appears to
do. The code is hard to reuse, hard to test and hard to parallelize.

Compare it with this:

    pipeline_each(bands, [set_canada_as_country,
                          strip_punctuation_from_name,
                          capitalize_names])

 
 This code is easy to understand. It gives the impression that the auxiliary
 functions are functional because they seem to be chained together. The output
 from the previous one comprises the input to the next. If they are functional,
 they are easy to verify. They are also easy to reuse, easy to test and easy to
 parallelize.

The job of `pipeline_each()` is to pass the bands, one at a time, to a
transformation function, like `set_canada_as_country()`. After the function has
been applied to all the bands, `pipeline_each()` bundles up the transformed
bands. Then, it passes each one to the next function.

Let’s look at the transformation functions.

    def set_canada_as_country(band)
      return band.merge country: 'Canada'
    end

    def strip_punctuation_from_name(band)
      return band.merge name: band[:name].delete('.')
    end
                          
    def capitalize_names(band)
      return band.merge name: band[:name].upcase
    end

Each one associates a key on a band with a new value. Everything seems fine.
Band dictionary originals are protected from mutation when a key is associated
with a new value. But there are two other potential mutations in the code
above. In `strip_punctuation_from_name()`, the unpunctuated name is generated
by calling `delete()` on the original name. In `capitalize_names()`, the
capitalized name is generated by calling `title()` on the original name. If
`replace()` and title() are not functional, strip_punctuation_from_name() and
`capitalize_names()` are not functional.  capitalize_names()` are not
functional.

Everything seems fine. Band dictionary originals are protected from mutation
when a key is associated with a new value. But there are two other potential
mutations in the code above. In `strip_punctuation_from_name()`, the
unpunctuated name is generated by calling `delete()` on the original name. In
`capitalize_names()`, the capitalized name is generated by calling `upcase()`
on the original name. If `delete()` and `upcase()` are not functional,
`strip_punctuation_from_name()` and `capitalize_names()` are not functional.

Fortunately, `delete()` and `upcase()` do not mutate the strings they operate
on.  When, for example, `delete()` operates on a band name string, the original
band name is copied and `delete()` is called on the copy. Phew.

**Exercise 4.** Try and write the `pipeline_each` function. Think about the order of operations. The bands in the array are passed, one band at a time, to the first transformation function. The bands in the resulting array are passed, one band at a time, to the second transformation function. And so forth.

My Solution:

    def pipeline_each(bands, funcs)
      bands.map {|band| funcs.inject(band) {|b, f| b = f[b]}}
    end

Or:

    def pipeline_each(bands, funcs)
      funcs.reduce(bands) {|d, f| d.map { |x| f[x] }}
    end

### What Now? ###

Functional code co-exists very well with code written in other styles. The transformations in this article can be applied to any code base in any language. Try applying them to your own code.

Think of Mary, Isla and Sam. Turn iterations of lists into maps and reduces.

Think of the race. Break code into functions. Make those functions functional. Turn a loop that repeats a process into a recursion.

Think of the bands. Turn a sequence of operations into a pipeline.

