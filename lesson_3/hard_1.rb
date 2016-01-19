# 1) The variable was defined inside theif false
if false
  greeting = 'hello world'
end
# greeting is intialized to nil
 # 2)
greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there' # this changes the original string without creating a new object

puts informal_greeting  #  => "hi there"
puts greetings # => {:a=>"hi there"}
# 3)
# A)
def mess_with_vars_a(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars_a(one, two, three) # => "two"

puts "one is: #{one}" # => "one"
puts "two is: #{two}" # => "two"
puts "three is: #{three}" # => "three"    method reassigned variables to new objects
# B)

def mess_with_vars_b(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars_b(one, two, three)

puts "one is: #{one}" # =>"one"
puts "two is: #{two}" # =>"two"
puts "three is: #{three}" # => "three"    methods point at new objects

# C)

def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" #=> "two"
puts "two is: #{two}" #=> "three"
puts "three is: #{three}" #=> "one"    methods modify existing object

# 4)

def uuid
  characters = (0..9).map { |x| x.to_s } + ('a'..'f').map { |x| x }
  uuid = ''
  32.times do
    uuid << characters.sample
  end
  uuid.insert(8, '-')
  uuid.insert(13, '-')
  uuid.insert(18, '-')
  uuid.insert(23, '-')
end
puts uuid


# 5)

def dot_separated_ip_address?(string)
  string.split(".").length == 4 && is_a_number?(string.delete("."))
end


p dot_separated_ip_address?('10.4.5.11')
p dot_separated_ip_address?("1.2.3.4.5")
p dot_separated_ip_address?("4.5.5")
