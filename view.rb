
# class Results
#   def initialize
#     @CORRECT_GUESS = 1
#     @INCORRECT_GUESS = 2
#     @GAME_WON = 3
#     @GAME_LOST = 4

#     @result_messages = {@CORRECT_GUESS => "Correct!",
#                          @INCORRECT_GUESS => "Nope!",
#                          @GAME_WON => "Well done, you won!",
#                          @GAME_LOST => "Oh no, you've lost!"}
#   end

#   attr_reader :CORRECT_GUESS
#   attr_reader :INCORRECT_GUESS
#   attr_reader :GAME_WON
#   attr_reader :GAME_LOST
#   attr_reader :result_messages
# end


class HangmanResults
  @CORRECT_GUESS = 1
  @INCORRECT_GUESS = 2
  @GAME_WON = 3
  @GAME_LOST = 4

  @result_messages = {@CORRECT_GUESS => "Correct!",
                      @INCORRECT_GUESS => "Nope!",
                      @GAME_WON => "Well done, you won!",
                      @GAME_LOST => "Oh no, you've lost!"}
  class << self
    attr_reader :CORRECT_GUESS
    attr_reader :INCORRECT_GUESS
    attr_reader :GAME_WON
    attr_reader :GAME_LOST
    attr_reader :result_messages
  end
end


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


class HangmanView

  def initialize(hangman_game)
    @hangman = hangman_game
    print `clear`
    puts "------------------hangman------------------"
  end

  def get_input
    print "Enter your guess >> "
    return gets.chomp
  end

  def print_status
    print "here's the word so far: "
    print_word_progress
    puts "you have #{@hangman.remaining_lives} lives remaining"
    print_used_letters
  end

  def print_word_progress
    @hangman.word.each_char do |i|
      if @hangman.correct_letters.include? i.downcase
        print i
      else
        print "*"
      end
    end
    print "\n"
  end

  def print_used_letters
    if @hangman.used_letters
      @hangman.used_letters.join(" ")
    end
  end

end









