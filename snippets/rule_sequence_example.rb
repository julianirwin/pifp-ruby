# def zero(s):
#     if s[0] == "0":
#         return s[1:]

# def one(s):
#     if s[0] == "1":
#         return s[1:]

# def rule_sequence(s, rules):
#     for rule in rules:
#         s = rule(s)
#         if s == None:
#             break

#     return s

def zero(s)
  if s[0] == "0"
    s[1..-1]
  end
end

def one(s)
  if s[1] == "1"
    s[1..-1]
  end
end

def rule_sequence(s, rules)
  rules.each do |rule|
    s = rule(s)
    break if s.nil?
  end
end



# p rule_sequence("0101", [zero, one, zero])
# => 1

# p rule_sequence("0101", [zero, zero])
# => None
