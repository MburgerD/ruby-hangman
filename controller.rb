require_relative 'model'
require_relative 'view'


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

  def take_turn
    @game_view.print_status
    validated_input = get_valid_input
    result_codes = get_game_result(validated_input)
    display_results(result_codes)

    game_status = update_game(result_codes, validated_input)
    display_status(game_status)
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

  def display_status(status_code)
    @game_view.display_status(status_code)
  end

  def get_game_result(input)
    return @game_model.get_result_codes(input)
  end

  def update_game(result_codes, input)
    result_codes.each {|code| @game_model.result_action(code, input)}
    return @game_model.status
  end

  def get_valid_input
    input_ok = false
    until input_ok
      input = @game_view.get_input
      input_error_codes = get_input_errors(input)
      input_ok = input_error_codes.empty?
      display_errors(input_error_codes)
    end
    return input
  end

end


hangman = GameController.new(HangmanModel, HangmanView)
hangman.play
