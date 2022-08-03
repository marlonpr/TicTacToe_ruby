require 'colorize'

# Game class, OOP Ruby
class Game
  attr_accessor :p1_name, :p2_name, :array, :p1_selector, :p2_selector, :selection, :rounds

  def initialize
    puts "TicTacToe game\n\nPlease enter player 1 name"
    @p1_name = gets.chomp
    set_p1_selector
    puts 'Please enter player 2 name'
    @p2_name = gets.chomp
    set_p2_selector
    @array = * (0..9)
    @selection = 1
    @rounds = 0
  end

  def set_p1_selector
    puts 'What 1 letter (or special character) would you like to be your game marker?'
    @p1_selector = gets.chomp
    return if @p1_selector.to_i.zero? && @p1_selector.length == 1 && @p1_selector != '0'

    puts 'Invalid selector, try again'.red
    set_p1_selector
  end

  def set_p2_selector
    puts "What 1 letter (or special character) would you like to be your game marker? \nIt cannot be '#{@p1_selector}'"
    @p2_selector = gets.chomp
    return if @p2_selector.to_i.zero? && @p2_selector.length == 1 && @p2_selector != @p1_selector && @p2_selector != '0'

    puts 'Invalid selector, try again'.red
    set_p2_selector
  end

  def generate_solutions(s)
    [
      ['x',s,s,s,'x','x','x','x','x','x'],
      ['x','x','x','x',s,s,s,'x','x','x'],
      ['x','x','x','x','x','x','x',s,s,s],
      ['x',s,'x','x',s,'x','x',s,'x','x'],
      ['x','x',s,'x','x',s,'x','x',s,'x'],
      ['x','x','x',s,'x','x',s,'x','x',s],
      ['x',s,'x','x','x',s,'x','x','x',s],
      ['x','x','x',s,'x',s,'x',s,'x','x']
    ]
  end

  def print_array(player, p_selec)
    @rounds += 1
    puts "  #{@array[1]} | #{@array[2]} | #{@array[3]}\n  ---+---+---\n  #{@array[4]} | #{@array[5]} | #{@array[6]}"
    puts "  ---+---+---\n  #{@array[7]} | #{@array[8]} | #{@array[9]}\n  ---+---+---"
    finalize_game(player, rounds) if win?(p_selec) || rounds == 9
  end

  def player1
    puts "#{@p1_name}, please enter a number (1-9) that is available to place an '#{@p1_selector}'"
    @selection = gets.chomp.to_i
    if (@array[@selection].is_a? Numeric) && @selection.positive? && @selection < 10
      @array[@selection] = @p1_selector
    else
      puts 'Invalid selection, try again'.red
      player1
    end
    print_array(@p1_name, @p1_selector)
  end

  def player2
    puts "#{@p2_name}, please enter a number (1-9) that is available to place an '#{@p2_selector}'"
    @selection = gets.chomp.to_i
    if (@array[@selection].is_a? Numeric) && @selection.positive? && @selection < 10
      @array[@selection] = @p2_selector
    else
      puts 'Invalid selection, try again'.red
      player2
    end
    print_array(@p2_name, @p2_selector)
  end

  def generate_checking_array(selector)
    @array.map do |x|
      x != selector ? 'x' : x
    end
  end

  def win?(selector)
    generate_solutions(selector).each do |x|
      match = 0
      x.each_index do |idx|
        match += 1 if x[idx] == generate_checking_array(selector)[idx] && x[idx] == selector
        return true if match == 3
      end
    end
    false
  end

  def play
    player1
    player2
  end

  def finalize_game(player, rounds)
    puts "It's a draw\nWould you like to play a new game? Press 'y' for yes or 'n' for no" if rounds == 9
    puts "#{player} is the winner!\nPlay again? Press 'y' for yes or 'n' for no" if player && rounds != 9
    if gets.chomp.downcase == 'y'
      start_game
    else
      puts 'Thanks for playing!'
      exit!
    end
  end
end

def start_game
  tic = Game.new
  loop do
    tic.play
  end
end

start_game
