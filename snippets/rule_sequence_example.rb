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

def rule_sequence(s, rules)
  rules.each do |rule|
    s = rule[s]
    break if s.nil?
  end
  return s
end

# There MUST be a ruby way to do this functionally. This way is crap.
zero = method :zero
one = method :one

p rule_sequence("0101", [zero, one, zero])
# => 1

p rule_sequence("0101", [zero, zero])
# => nil
