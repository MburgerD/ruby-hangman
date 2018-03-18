require_relative 'view'


class HangmanModel

  def initialize(word='Timetable', remaining_lives=5)
    @word = word
    @used_letters = []
    @remaining_lives = remaining_lives
  end

  attr_reader :word, :used_letters, :remaining_lives

  def take_turn(char)
    char = char.downcase
    used_letters.push(char)

    [].tap do |result_codes|
      if letter_in_word?(char)
        result_codes << HangmanResults::CORRECT_GUESS
      else
        deduct_life
        result_codes << HangmanResults::INCORRECT_GUESS
      end
    end
  end

  def get_turn_input_error_codes(input)
    [].tap do |error_codes|
      if not one_character_entered?(input)
        error_codes << HangmanInputErrors::MULTIPLE_CHARACTERS
      end

      if not character_is_alpha?(input)
        error_codes << HangmanInputErrors::NOT_ALPHA
      end

      if error_codes.empty?
        if letter_used?(input)
          error_codes << HangmanInputErrors::USED_LETTER
        end
      end
    end
  end

  def game_over?
    game_won? or game_lost?
  end

  def game_won?
    all_letters_guessed?
  end

  def game_lost?
    no_lives_remaining?
  end

  def correct_letters
    word.downcase.split('').uniq & used_letters
  end

  private

  def deduct_life
    @remaining_lives -= 1
  end

  def letter_used?(char)
    used_letters.include? char.downcase
  end

  def letter_in_word?(char)
    word.downcase.include? char.downcase
  end

  def one_character_entered?(input)
    input.length == 1
  end

  def character_is_alpha?(char)
    /^[[:alpha:]]$/ === char
  end

  def no_lives_remaining?
    @remaining_lives == 0
  end

  def all_letters_guessed?
    word.downcase.split('').uniq.length == correct_letters.uniq.length
  end
  
end
