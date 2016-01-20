
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
  system 'clear'
  prompt "You're a '#{PLAYER_MARKER}'. Computer is '#{COMPUTER_MARKER}'."
  puts <<-DISPLAY_BOARD
     ----- ----- -----
    |     |     |     |
    |  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  |
    |     |     |     |
     -----+-----+-----
    |     |     |     |
    |  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  |
    |     |     |     |
     -----+-----+-----
    |     |     |     |
    |  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  |
    |     |     |     |
     ----- ----- -----
  DISPLAY_BOARD
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a position to place a piece: #{joinor(empty_squares(brd), ', ')}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = if winning_opportunity?(brd, COMPUTER_MARKER)
             locate_winning_opportunity(brd, COMPUTER_MARKER)
           elsif winning_opportunity?(brd, PLAYER_MARKER)
             locate_winning_opportunity(brd, PLAYER_MARKER)
           elsif brd[5] == INITIAL_MARKER
             5
           else
             empty_squares(brd).sample
           end
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.any? do |line|
    return "Player" if brd.values_at(*line).all? { |squares| squares == 'X' }
    return "Computer" if brd.values_at(*line).all? { |squares| squares == 'O' }
  end
  nil
end

def joinor(arr, delimiter, word='or')
  arr[-1] = "#{word} #{arr.last}" if arr.size > 1
  arr.join(delimiter)
end

def winning_opportunity?(brd, marker)
  WINNING_LINES.find do |line|
    brd.values_at(*line).count(marker) == 2 &&
      brd.values_at(*line).count(INITIAL_MARKER) == 1
  end
end

def locate_winning_opportunity(brd, marker)
  winning_opportunity?(brd, marker).find { |num| brd[num] == INITIAL_MARKER }
end

def place_piece!(brd, current_player)
  player_places_piece!(brd) if current_player == "Player"
  computer_places_piece!(brd) if current_player == "Computer"
end

def alternate_player(current_player)
  return "Player" if current_player == "Computer"
  return "Computer" if current_player == "Player"
end

player_score = 0
computer_score = 0

system 'clear'
puts '*' * 80
puts " Welcome to Tic Tac Toe Game! ".center(80, "*")
puts " Select 1 for top left, 2 for top middle, 3 for top right,  ".center(80, "*")
puts " 4 for middle left, 5 for middle middle, 6 for middle right,  ".center(80, "*")
puts " 7 for bottom left, 8 for bottom middle, 9 for bottom right.  ".center(80, "*")
puts '*' * 80

prompt "Press 'ENTER' to begin..."
gets

loop do
  board = initialize_board
  current_player = "Computer"
  display_board(board)
  prompt "Do you want to play first? Enter 'y' for yes:"
  first = gets.chomp.downcase
  current_player = "Player" if first == 'y'

  loop do
    display_board(board)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
    player_score += 1 if detect_winner(board) == 'Player'
    computer_score += 1 if detect_winner(board) == 'Computer'
  else
    prompt "It's a tie!"
  end

  prompt "The scores are Player: #{player_score}; Computer #{computer_score}."

  break if player_score >= 5 || computer_score >= 5

  prompt "Press enter to start next round or 'exit' to exit:"
  continue = gets.chomp.downcase
  break if continue == 'exit'
end

if player_score >= 5
  prompt "Congratulations, you have won!"
elsif computer_score >= 5
  prompt "Sorry, you have lost!"
end

puts '*' * 80
puts " Thanks for playing. Good bye! ".center(80, "*")
puts '*' * 80
