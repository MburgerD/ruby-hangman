class HangmanInputErrors
  @MULTIPLE_CHARACTERS = 1
  @NOT_ALPHA = 2
  @USED_LETTER = 3

  @input_error_messages = {@MULTIPLE_CHARACTERS => "You must only enter one character",
               @NOT_ALPHA => "You must enter a letter",
                 @USED_LETTER => "You've already guessed that letter"}
  class << self
    attr_reader :MULTIPLE_CHARACTERS
    attr_reader :NOT_ALPHA
    attr_reader :USED_LETTER
    attr_reader :input_error_messages
  end
end


class HangmanSetupInputRules

end



    error_codes = []

    if not one_character_entered(input)
      error_codes << InputErrors.MULTIPLE_CHARACTERS
    end

    if not character_is_alpha(input)
      error_codes << InputErrors.NOT_ALPHA
    end

    if error_codes.empty?
      if @game_model.letter_used(input)
        error_codes << InputErrors.USED_LETTER
      end
    end

class InputRule
  @error_message = ''

  def check


class HangmanGuessInputRules
  @RULES = 

   def one_character_entered(input)
    return input.length == 1
  end

  def character_is_alpha(char)
    return /^[[:alpha:]]$/ === char
  end
  # @MULTIPLE_CHARACTERS = 1
  # @NOT_ALPHA = 2
  # @USED_LETTER = 3

  # @input_error_messages = {@MULTIPLE_CHARACTERS => "You must only enter one character",
  #              @NOT_ALPHA => "You must enter a letter",
  #                @USED_LETTER => "You've already guessed that letter"}
  # class << self
  #   attr_reader :MULTIPLE_CHARACTERS
  #   attr_reader :NOT_ALPHA
  #   attr_reader :USED_LETTER
  #   attr_reader :input_error_messages
  # end

end


class HangmanModel
  """
  Hold the game status
  """

  def initialize(word='Timetable', remaining_lives=5)
    @word = word
    @used_letters = []
    @correct_letters = []  # store in lower case
    @remaining_lives = 5
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

  



    
  def no_lives_remaining
    return @remaining_lives == 0
  end

  def all_letters_guessed
    return @word.downcase.split('').uniq.length == @correct_letters.uniq.length
  end
    

end


# results = Results.new
# puts results.CORRECT_GUESS
# puts results.result_messages[1]










