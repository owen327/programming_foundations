SUITS = ["\u{2660}", "\u{2665}", "\u{2663}", "\u{2666}"]
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
TARGET = 21
STAYS_AT = 17

def initialize_deck
  SUITS.product(VALUES)
end

def prompt(message)
  puts "=> #{message}"
end

def total(cards)
  values = cards.map do |card|
    card[1].gsub(/[AKQJ]/, 'A' => 11, 'K' => 10, 'Q' => 10, 'J' => 10).to_i
  end
  total = values.reduce(:+)
  values.count(11).times { total -= 10 if total > TARGET }
  total
end

def display_cards(human_cards, dealer_cards, show='dont_show')
  system 'clear'
  prompt "Dealer has: #{dealer_cards[0..-2]} + ?" if show == 'dont_show'
  prompt "Dealer has: #{dealer_cards}" if show == 'show'
  prompt "Dealer total is #{total(dealer_cards)}" if show == 'show'
  puts "*" * 80
  prompt "You have: #{human_cards}"
  prompt "Your total is #{total(human_cards)}"
  puts "*" * 80
end

def busted?(cards)
  total(cards) > TARGET
end

def detect_results(human_cards, dealer_cards, human_total, dealer_total)
  case
  when total(human_cards) == TARGET
    :human_21
  when total(dealer_cards) == TARGET
    :dealer_21
  when total(human_cards) > TARGET
    :human_busted
  when total(dealer_cards) > TARGET
    :dealer_buster
  when total(human_cards) > human_total
    :human_win
  when total(human_cards) < dealer_total
    :dealer_win
  else
    :tie
  end
end

def display_results(human_cards, dealer_cards, human_total, dealer_total)
  case detect_results(human_cards, dealer_cards, human_total, dealer_total)
  when :human_21
    prompt "You have hit #{TARGET}, you win this round! "
  when :dealer_21
    prompt "Dealer has hit #{TARGET}, you lose this round!"
  when :human_busted
    prompt "You have busted, you lose this round!"
  when :dealer_buster
    prompt "Dealer has busted, you win this round!"
  when :human_win
    prompt "You win this round!"
  when :dealer_win
    prompt "You lose this round!"
  when :tie
    prompt "This round is a tie!"
  end
end

def winner?(player, human_cards, dealer_cards, human_total, dealer_total)
  case detect_results(human_cards, dealer_cards, human_total, dealer_total)
  when :human_21, :dealer_buster, :human_win
    return true if player == :human
  when :dealer_21, :human_busted, :dealer_win
    return true if player == :dealer
  else
    false
  end
end

def hit_or_stay
  loop do
    prompt "Enter 'h' to hit 's' to stay?"
    answer = gets.chomp.downcase
    return answer if answer == 'h' || answer == 's'
    prompt "Please enter only 'h' or 's'!"
  end
end

human_score = 0
dealer_score = 0

system 'clear'
puts " Welcome to Twenty One! ".center(80, '*')
prompt "Press enter to begin..."
gets

loop do
  deck = initialize_deck.shuffle

  human_cards = []
  dealer_cards = []

  2.times { human_cards << deck.pop }
  2.times { dealer_cards << deck.pop }

  human_total = total(human_cards)
  dealer_total = total(dealer_cards)

  answer = nil

  loop do
    display_cards(human_cards, dealer_cards)
    prompt "You chose to hit and got #{human_cards[-1]}" if answer == 'h'
    break if answer == 's' || busted?(human_cards) || human_total == TARGET
    answer = hit_or_stay
    human_cards << deck.pop if answer == 'h'
    human_total = total(human_cards) if answer == 'h'
  end

  if answer == 's'
    display_cards(human_cards, dealer_cards, 'show')
    prompt "You chose to stay at #{human_total}."
    prompt "Dealer reveals card #{dealer_cards[-1]}"
    loop do
      prompt "Press enter to continue"
      gets
      break if dealer_total >= STAYS_AT
      dealer_cards << deck.pop
      dealer_total = total(dealer_cards)
      display_cards(human_cards, dealer_cards, 'show')
      prompt "Dealer hits and got #{dealer_cards[-1]}"
    end
    display_cards(human_cards, dealer_cards, 'show')
    prompt "Dealer stays at #{dealer_total}!" unless busted?(dealer_cards) ||
                                              total(dealer_cards) == TARGET
  end

  display_results(human_cards, dealer_cards, human_total, dealer_total)

  human_score += 1 if winner?(:human, human_cards, dealer_cards,
                              human_total, dealer_total)
  dealer_score += 1 if winner?(:dealer, human_cards, dealer_cards,
                              human_total, dealer_total)

  prompt "The scores are Player: #{human_score}; Dealer: #{dealer_score}."

  break if human_score >= 5 || dealer_score >= 5

  prompt "Play again? Enter 'y' for yes!"
  again = gets.chomp.downcase
  break unless again == 'y'
end

puts " Congratulations, you have won! ".center(80, '*') if human_score == 5
puts " Sorry, you have lost! ".center(80, '*') if dealer_score == 5
puts " Thank you for playing Twent-One! Good bye! ".center(80, '*')
