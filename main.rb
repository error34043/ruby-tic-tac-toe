class Board

  def initialize(board_state_array)
    @box1 =board_state_array[0]
    @box2 =board_state_array[1]
    @box3 =board_state_array[2]
    @box4 =board_state_array[3]
    @box5 =board_state_array[4]
    @box6 =board_state_array[5]
    @box7 =board_state_array[6]
    @box8 =board_state_array[7]
    @box9 =board_state_array[8]
    @victory = false
  end

  def row(b1, b2, b3)
    " #{b1} | #{b2} | #{b3} "
  end

  def divider
    "---+---+---"
  end

  def display_board
    @row1 = row(@box1, @box2, @box3)
    @row2 = row(@box4, @box5, @box6)
    @row3 = row(@box7, @box8, @box9)
    puts "\n\t\t\t#{@row1}\n\t\t\t#{divider}\n\t\t\t#{@row2}\n\t\t\t#{divider}\n\t\t\t#{@row3}"
  end

  def player_choice(board_state_array, box)
    board_state_array[box - 1] = 'X'
  end
  
  def victory?
    @victory = true if @box1 == @box4 && @box1 == @box7
    @victory = true if @box2 == @box5 && @box2 == @box8
    @victory = true if @box3 == @box6 && @box3 == @box9
    @victory = true if @box1 == @box5 && @box1 == @box9
    @victory = true if @box3 == @box5 && @box3 == @box7
    @victory
  end

end

class Player
  
  attr_accessor :name, :token

  def initialize(name, token)
    @name = name
    @token = token
  end

  def get_input(board_array)
    loop do
      print "#{@name}, please enter a number>> "
      choice = gets.chomp.to_i
      if board_array.include? choice
        return choice
      else
        puts "Please enter a number that has not yet been chosen by either player."
      end
    end
  end

end

class GamePlay

  def self.turn(board_array, player, player_choice)
    board_array[player_choice - 1] = player.token
    current_play = Board.new(board_array)
    current_play.display_board
    current_play.victory?
  end

end


puts "Welcome! Let's set you both up for a nice little game of Tic Tac Toe."
print "\nPlease enter the first player's name>> "
player1name = gets.chomp
Player1 = Player.new(player1name, 'X')
print "\nPlease enter the second player's name>> "
player2name = gets.chomp
Player2 = Player.new(player2name, 'O')

board_state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
start = Board.new(board_state)
start.display_board

# Testing
current = GamePlay.turn(board_state, Player1, 3)
GamePlay.turn(board_state, Player2, 6)
GamePlay.turn(board_state, Player1, 9)
choice1 = Player1.get_input(board_state)
if current == false
  puts "this works"
end
puts choice1