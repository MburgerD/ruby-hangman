require_relative 'view'


class HangmanModel

  def initialize(word='Timetable', remaining_lives=5)
    @word = word
    @used_letters = []
    @correct_letters = []  # store in lower case
    @remaining_lives = remaining_lives
    @game_won = false
    @game_lost = false
    @game_over = false
  end

  attr_reader :word
  attr_reader :used_letters
  attr_reader :correct_letters
  attr_reader :remaining_lives
  attr_reader :game_over
  attr_reader :game_won
  attr_reader :game_lost

  def deduct_life
    @remaining_lives -= 1
  end

  def letter_used(char)
    return @used_letters.include? char.downcase
  end

  def letter_in_word(char)
    return @word.downcase.include? char.downcase
  end

  def take_turn(char)
    char = char.downcase
    result_codes = []
    @used_letters.push(char)

    if letter_in_word(char)
      @correct_letters.push(char)
      result_codes << HangmanResults.CORRECT_GUESS
    else
      deduct_life
      result_codes << HangmanResults.INCORRECT_GUESS
    end

    update_status
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

  def update_status
    if no_lives_remaining
      @game_lost = true
      @game_over = true
    elsif all_letters_guessed
      @game_won = true
      @game_over = true
    end
  end

  def no_lives_remaining
    return @remaining_lives == 0
  end

  def all_letters_guessed
    return @word.downcase.split('').uniq.length == @correct_letters.uniq.length
  end
  
end
