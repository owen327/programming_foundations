VALID_CHOICES = { r: 'rock', p: 'paper', sc: 'scissors', l: 'lizard', sp: 'spock' }

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  (first == 'rock' && %w(scissors lizard).include?(second)) ||
    (first == 'paper' && %w(rock spock).include?(second)) ||
    (first == 'scissors' && %w(paper lizard).include?(second)) ||
    (first == 'lizard' && %w(paper spock).include?(second)) ||
    (first == 'spock' && %w(scissor rock).include?(second))
end

def display_results(human, computer)
  if win?(human, computer)
    prompt "You won this round!"
  elsif win?(computer, human)
    prompt "Computer won this round!"
  else
    prompt "It's a tie!"
  end
end

def prompt_for_choice
  VALID_CHOICES.each do |key, value|
    prompt "Select '#{key}' for #{value}"
  end
end

def get_valid_choice
  loop do
    prompt_for_choice
    input = gets.chomp
    human_choice = VALID_CHOICES[input.to_sym]
    system 'clear'
    prompt "Your choice is not valid! Please try again." if human_choice.nil?
    return human_choice unless human_choice.nil?
  end
end

def display_final_results(human_score, computer_score)
  if human_score > computer_score
    puts '*' * 80
    puts " Congratulations, you have won the game! ".center(80, "*")
  else
    puts '*' * 80
    puts " Sorry, you have lost! ".center(80, "*")
  end
  puts " Thanks for playing. Good bye! ".center(80, "*")
  puts '*' * 80
end

human_score = 0
computer_score = 0

system 'clear'

puts '*' * 80
puts " Welcome to ROCK, SCISSORS, PAPER, LIZARD, SPOCK! ".center(80, "*")
puts '*' * 80

loop do
  human_choice = get_valid_choice

  computer_choice = VALID_CHOICES.values.sample

  prompt "You chose: #{human_choice}; Computer chose: #{computer_choice}"

  display_results(human_choice, computer_choice)

  human_score += 1 if win?(human_choice, computer_choice)
  computer_score += 1 if win?(computer_choice, human_choice)

  prompt "Your score: #{human_score}"
  prompt "Computer score: #{computer_score}"

  break if human_score >= 5 || computer_score >= 5
end

display_final_results(human_score, computer_score)
