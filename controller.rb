
class GameController
  def initialize(game_model, game_view)
    @game_model = game_model
    @game_view = game_view
  end

  def play
    @game_view.print_start_game
    until @game_model.game_over?
      @game_view.print_status
      validated_input = get_valid_input
      result_codes = @game_model.take_turn(validated_input)
      send_results_to_view(result_codes)
    end
    game_over
  end

  def game_over
    if @game_model.game_won?
      @game_view.game_won
    else
      @game_view.game_lost
    end
  end 

  def send_errors_to_view(error_codes)
    error_codes.each {|code| @game_view.display_error(code)}
  end

  def send_results_to_view(result_codes)
    result_codes.each {|code| @game_view.display_result(code)}
  end

  def get_valid_input
    input_ok = false
    until input_ok
      input = @game_view.get_input
      input_error_codes = @game_model.get_turn_input_error_codes(input)
      input_ok = input_error_codes.empty?
      send_errors_to_view(input_error_codes)
    end
    input
  end

end
