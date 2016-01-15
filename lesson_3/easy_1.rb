1) numbers = [1, 2, 2, 3]
   numbers.uniq
   puts numbers
=> original array as uniq does not mutate the array.
2) != means not equals and is used for comparison.
   !object returns boolean value for false
   !!object returns boolean value for true
   method! mutates self
   method? returns a boolean value
3) gsub('replace me', 'with me')
4) numbers = [1, 2, 3, 4, 5]
   numbers.delete_at(1) => deletes at index number(1)
   numbers.delete(1) => deletes value 1 from array
5) (10..100).include?(42) or (10..100).cover?(42)
6) famous_words = "seven years ago..."
   "Four score and " + famous_words
   famous_words.prepend("Four score and ")
7) 42
8) flintstones.flatten!
9) flintstones.assoc("Barney")
10) flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
  hash = Hash.new
  flintstones.each_with_index { |name, index| hash[name] = index }
