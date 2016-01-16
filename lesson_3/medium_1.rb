# 1)
(1..10).each { |num| puts "#{" " * (num - 1)}The Flintstones Rock!" }
10.times { |number| puts (" " * number) + "The Flintstones Rock!" }
# 2)
statement = "The Flintstones Rock"
frequency = Hash.new(0)
statement.each_char do |char|
  frequency[char] = statement.count(char) if char != " "
end
# 3)
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{(40 + 2)}"
# 4) first 1 3 second 1 2
# 5)
def factors(number)
  dividend = number
  divisors = []
  while dividend > 0 do
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end
#Bonus 1 number % dividend == 0 checks to see if it divides with no remainder.
#Bonus 2 line 22 returns the divisors array.
# 6) the first buffer will mutate the buffer array, the second nothing is mutated.
# 7)
def fib(first_num, second_num, limit)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 15)
puts "result is #{result}"
# 8)
def titleize(string)
  string.split.each { |word| word.capitalize! }.join(' ')
end
puts titleize("me me me")
# 9)
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
munsters.each do |key, value|
  case value["age"]
  when 0..18
     value["age_group"] = "kid"
  when 18..65
    value["age_group"] = "adult"
  else
    value["age_group"] = "senior"
  end
end

p munsters
