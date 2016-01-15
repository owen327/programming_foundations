1)
!!ages["Spot"]
ages.has_key?("Spot")
ages.key?("Spot")
ages.include?("Spot")
ages.member?("Spot")
2) total = 0
ages.values.each { |age| total += age }
ages.values.inject(:+)
ages.values.reduce(:+)
3) ages.delete_if {|_, age| age > 100 }
ages.keep_if { |_, age| age < 100 }
4) munsters_description = "The Munsters are creepy in a good way."
munsters_description.capitalize!
munsters_description.swapcase!
munsters_description.downcase!
munsters_description.upcase!
5) ages.merge!(additional_ages)
6) ages.values.min
7) advice.match("Dino")
advice.include?("Dino")
8) flintstones.find_index {|name| name.start_with?("Be") }
flintstones.index {|name| name.start_with?("Be") }
flintstones.index { |name| name[0, 2] == "Be" }
9) flintstones.map! { |name| name[0, 3] }
10)
