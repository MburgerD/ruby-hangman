class GameController
  def initialize(model, view)
    @model = model
    @view = view
  end

  def play
    view.print_start_game
    until model.game_over?
      view.print_status
      validated_input = valid_input
      result_codes = model.take_turn(validated_input)
      send_results_to_view(result_codes)
    end
    game_over
  end

  private

  attr_reader :model, :view

  def game_over
    if model.game_won?
      view.game_won
    else
      view.game_lost
    end
  end

  def send_errors_to_view(error_codes)
    error_codes.each { |code| view.display_error(code) }
  end

  def send_results_to_view(result_codes)
    result_codes.each { |code| view.display_result(code) }
  end

  def valid_input
    input_ok = false
    until input_ok
      input = view.user_input
      input_error_codes = model.turn_input_error_codes(input)
      input_ok = input_error_codes.empty?
      send_errors_to_view(input_error_codes)
    end
    input
  end
end
