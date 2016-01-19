WINNING_COMBOS = ([[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7]] +
                  [[2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]])

def initialize_grid
  { 1 => '_',2 => '_', 3 => '_', 4 => '_', 5 => '_',
    6 => '_',7 => '_', 8 => '_', 9 => '_' }
end

def prompt(message)
  puts "=> #{message}"
end

def display_grid(grid)
  system 'clear'
  puts " _ _ _"
  puts "|#{grid[1]}|#{grid[2]}|#{grid[3]}|"
  puts " _ _ _"
  puts "|#{grid[4]}|#{grid[5]}|#{grid[6]}|"
  puts " _ _ _"
  puts "|#{grid[7]}|#{grid[8]}|#{grid[9]}|"
end

def winner?(grid)
  WINNING_COMBOS.any? do |combo|
    return "Player" if grid.values_at(*combo).all? { |squares| squares == 'X'}
    return "Computer" if grid.values_at(*combo).all? { |squares| squares == 'O'}
  end
  nil
end

def grid_full?(grid)
  !grid.value?('_')
end

def human_turn(grid)
  square = ''
  loop do
    prompt "Input a square:"
    square = gets.chomp.to_i
    break if grid[square] == '_'
    prompt "Not valid. Try again!"
  end
  grid[square] = 'X'
end

def computer_turn(grid)
  square = grid.select { |_, square| square == '_' }.keys.sample
  grid[square] = 'O'
end

system 'clear'
puts '*' * 80
puts " Welcome to Tic Tac Toe Game! ".center(80, "*")
puts " Select 1 for top left, 2 for top middle, 3 for top right,  ".center(80, "*")
puts " 4 for middle left, 5 for middle middle, 6 for middle right,  ".center(80, "*")
puts " 7 for bottom left, 8 for bottom middle, 9 for bottom right.  ".center(80, "*")
puts '*' * 80

prompt "Press any key to begin..."
gets

loop do
  grid = initialize_grid
  loop do
    display_grid(grid)
    human_turn(grid)
    break if winner?(grid) || grid_full?(grid)

    computer_turn(grid)
    break if winner?(grid) || grid_full?(grid)
  end

  display_grid(grid)

  if winner?(grid)
    prompt "#{winner?(grid)} won!"
  else
    prompt "It's a tie!"
  end

  prompt "Do you want to play again? (Y)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

puts '*' * 80
puts " Thanks for playing. Good bye! ".center(80, "*")
puts '*' * 80
