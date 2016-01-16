# 1)
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}
# males = munsters.select do |key, value|
#   value.has_value?("male")
# end
# males_ages = males.map do |key, value|
#    males[key]["age"]
# end
# p males_ages.reduce(:+)
total_male_age = 0
munsters.each do |name, details|
  total_male_age += details["age"] if details["gender"] == "male"
end
# 2)
puts
munsters.each do |name, details|
  puts "#{name} is a #{details['age']} year old #{details['gender']}."
end
# 3)
puts
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += ["rutabaga"]

  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"
# 4)
puts
sentence = "Humpty Dumpty sat on a wall."
puts sentence.split(/\W/).reverse.join(' ') + '.'
# 5) 34 as orignial answer was not mutated
# 6)
puts
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end
p mess_with_demographics(munsters)
p munsters
# the munsters hash was mutated

# 7)
puts
