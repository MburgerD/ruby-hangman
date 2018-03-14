require_relative 'model'
require_relative 'view'


# get input in the view
# in the controller - view.get_input
# input validation in the game
# make the controller non-specific to hangman - call it GameController
# rspec


class GameController
  def initialize(game_model, game_view)
    @game_model = game_model.new
    @game_view = game_view.new(@game_model)
  end

  def setup
    @game_model.setup
  end

  def play
    setup
    until @game_model.game_over
      take_turn
    end
  end

  def get_input_errors(input)
    return @game_model.get_turn_input_error_codes(input)
  end

  def display_errors(error_codes)
    error_codes.each {|code| @game_view.display_error(code)}
  end

  def display_results(result_codes)
    result_codes.each {|code| @game_view.display_result(code)}
  end

  def check_result(input)
    return @game_model.get_result_codes(input)
  end

  def update_game(result_codes)
    result_codes.each {|code| @game_model.result_action(code)}
  end

  def get_valid_input
    input_ok = false
    until input_ok
      input = @game_view.get_input
      input_error_codes = check_input_errors(input)
      input_ok = input_error_codes.empty?
      display_errors(input_error_codes)
    end
    return input
  end

  def take_turn
    @game_view.print_status
    validated_input = get_valid_input
    result_codes = check_result(validated_input)
    display_results(result_codes)

    # status_changes = update_game(result_codes)

    @used_letters.push(validated_input)

    if guess_is_correct(validated_input)
      puts "Correct!"
      @correct_letters.push(validated_input)
      print_word_progress
    else
      puts "Damn, the word does not contain #{validated_input}!"
      deduct_life
    end

    if no_lives_remaining
      puts "\n\nGame over, you've run out of lives!"
      puts "The word was #{@word}"
      @game_model.game_over = true
    elsif all_letters_guessed
      puts "\n\nWell done, you got it!"
      @game_model.game_over = true
    end

    print "\n"
  end

 
  

end


hangman = GameController.new(HangmanModel, HangmanView)
hangman.play
