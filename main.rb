class Board

  def initialize(board_state_array)
    @box1 = board_state_array[1]
    @box2 = board_state_array[2]
    @box3 = board_state_array[3]
    @box4 = board_state_array[4]
    @box5 = board_state_array[5]
    @box6 = board_state_array[6]
    @box7 = board_state_array[7]
    @box8 = board_state_array[8]
    @box9 = board_state_array[9]
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
  
  def victory?
    @victory = true if @box1 == @box4 && @box1 == @box7
    @victory = true if @box2 == @box5 && @box2 == @box8
    @victory = true if @box3 == @box6 && @box3 == @box9
    @victory = true if @box1 == @box5 && @box1 == @box9
    @victory = true if @box3 == @box5 && @box3 == @box7
    @victory = true if @box1 == @box2 && @box1 == @box3
    @victory = true if @box4 == @box5 && @box4 == @box6
    @victory = true if @box7 == @box8 && @box7 == @box9
    @victory
  end

end

class Player
  
  attr_accessor :name, :token

  def initialize(name, token)
    @name = name
    @token = token
  end

  def get_input(board_array, choice = gets.chomp)
    loop do
      choice = choice.to_i
      if board_array.include? choice
        return choice
      else
        puts "\n#{@name}, please enter a number that has not yet been chosen by either player."
        print "#{@name}, please enter a number: "
        choice = gets.chomp
        return false
      end
    end
  end

end

class GamePlay

  def self.turn(board_array, player, player_choice)
    board_array[player_choice] = player.token
    current_play = Board.new(board_array)
    current_play.display_board
    current_play.victory?
  end

  def self.replay_choice
    choices = ['yes', 'y', 'no', 'n']

    loop do
      print "Would you like to play another game? [yes/no]: "
      player_choice = gets.chomp
      player_choice = player_choice.downcase
      if choices.include? player_choice
        if player_choice == 'yes' || player_choice == 'y'
          puts "\nGreat! Let's go again."
          check = true
          return check
        else
          puts "\nThank you both for playing!"
          check = false
          return check
        end
      else
        puts "\nSorry, I didn't get that. Please tell me again."
        return 'invalid'
      end
    end
  end

  def self.game_over(player1state, game_state, player1name, player2name)
    if player1state && game_state
      puts "\nCongratulations, #{player1name}. You win!"
    elsif game_state
      puts "\nCongratulations, #{player2name}. You win!"
    else
      puts "\nYou've both tied, #{player1name} and #{player2name}!"
    end
  end

end

class Game
  attr_accessor :player1, :player2

  def player1turn(player1, player2)
    print "\n#{player1.name}, please enter a number: "
    player_choice = player1.get_input(@board_state)
    current = GamePlay.turn(@board_state, player1, player_choice)
    if current == true
      player1_win = true
      game_win = true
      GamePlay.game_over(player1_win, game_win, player1.name, @player2.name)
    end
    current == true ? true : false
  end

  def player2turn(player1, player2)
    print "\n#{player2.name}, please enter a number: "
    player_choice = player2.get_input(@board_state)
    current = GamePlay.turn(@board_state, player2, player_choice)
    if current == true
      player1_win = false
      game_win = true
      GamePlay.game_over(player1_win, game_win, player1.name, player2.name)
    end
    current == true ? true : false
  end

  def generate_players
    puts "Welcome! Let's set you two up for a nice little game of Tic Tac Toe."
    print "\nPlease enter the first player's name: "
    player1name = gets.chomp
    @player1 = Player.new(player1name, 'X')
    print "Please enter the second player's name: "
    player2name = gets.chomp
    @player2 = Player.new(player2name, 'O')
  end

  def new_game
    generate_players

    loop do
      continue_play = true

      @board_state = ['unused', 1, 2, 3, 4, 5, 6, 7, 8, 9]
      start = Board.new(@board_state)
      start.display_board

      player1_win = false
      game_win = false
      for i in 1..9
        if i % 2 != 0
          won = player1turn(@player1, @player2)
          break if won
        else
          won = player2turn(@player1, @player2)
          break if won
        end
      end

      if won == false
        GamePlay.game_over(player1_win, game_win, player1.name, player2.name)
      end

      loop do
        replay = GamePlay.replay_choice
        if replay == true || replay == false
          continue_play = replay
          break
        end
      end
      
      break if continue_play == false

    end
  end
end

# game = Game.new.new_game