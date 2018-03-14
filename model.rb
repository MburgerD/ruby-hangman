require_relative 'view'


class HangmanModel
  """
  Hold the game status
  """

  def initialize(word='Timetable', remaining_lives=5)
    @word = word
    @used_letters = []
    @correct_letters = []  # store in lower case
    @remaining_lives = remaining_lives
    @game_over = false
  end

  attr_reader :word
  attr_reader :used_letters
  attr_reader :correct_letters
  attr_reader :remaining_lives
  attr_reader :game_over


  def deduct_life
    @remaining_lives -= 1
  end

  def letter_used(char)
    char = char.downcase
    return @used_letters.include? char
  end

  def letter_in_word(char)
    return @word.downcase.include? char.downcase
  end
  
  def setup
  end

  def get_result_codes(char)
    result_codes = []
    if letter_in_word(char)
      result_codes << HangmanResults.CORRECT_GUESS
    else
      result_codes << HangmanResults.INCORRECT_GUESS
    end
    return result_codes
  end

  def one_character_entered(input)
    return input.length == 1
  end

  def character_is_alpha(char)
    return /^[[:alpha:]]$/ === char
  end

  def get_turn_input_error_codes(input)
    error_codes = []

    if not one_character_entered(input)
      error_codes << HangmanInputErrors.MULTIPLE_CHARACTERS
    end

    if not character_is_alpha(input)
      error_codes << HangmanInputErrors.NOT_ALPHA
    end

    if error_codes.empty?
      if letter_used(input)
        error_codes << HangmanInputErrors.USED_LETTER
      end
    end
    return error_codes
  end

  def result_action(result_code, char)
    @used_letters.push(char)

    if result_code == HangmanResults.CORRECT_GUESS
      @correct_letters.push(char)
    elsif result_code == HangmanResults.INCORRECT_GUESS
      deduct_life
    end

    return status
  end

  def status
    if no_lives_remaining      
      @game_over = true
      return HangmanStatuses.GAME_LOST
    elsif all_letters_guessed
      @game_over = true
      return HangmanStatuses.GAME_WON
    else
      return HangmanStatuses.GAME_CONTINUES
    end
  end

  def no_lives_remaining
    return @remaining_lives == 0
  end

  def all_letters_guessed
    return @word.downcase.split('').uniq.length == @correct_letters.uniq.length
  end
  
end
