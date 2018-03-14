
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

  @result_messages = {@CORRECT_GUESS => "Correct!",
                      @INCORRECT_GUESS => "Nope!"}
  class << self
    attr_reader :CORRECT_GUESS
    attr_reader :INCORRECT_GUESS
    attr_reader :result_messages
  end
end


class HangmanStatuses
  @GAME_WON = 1
  @GAME_LOST = 2
  @GAME_CONTINUES = 3

  @status_messages = {@GAME_WON => "Well done, you won!",
                      @GAME_LOST => "Oh no, you've lost!",
                      @GAME_CONTINUES => ""}
  class << self
    attr_reader :GAME_WON
    attr_reader :GAME_LOST
    attr_reader :GAME_CONTINUES
    attr_reader :status_messages
  end
end


class HangmanInputErrors
  @MULTIPLE_CHARACTERS = 1
  @NOT_ALPHA = 2
  @USED_LETTER = 3

  @error_messages = {@MULTIPLE_CHARACTERS => "You must only enter one character",
                     @NOT_ALPHA => "You must enter a letter",
                     @USED_LETTER => "You've already guessed that letter"}
  class << self
    attr_reader :MULTIPLE_CHARACTERS
    attr_reader :NOT_ALPHA
    attr_reader :USED_LETTER
    attr_reader :error_messages
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
    if not @hangman.used_letters.empty?
      print "Letters you've guessed: "
      puts @hangman.used_letters.join(" ")
    end
  end

  def reveal_word
    puts "The word was #{@hangman.word}"
  end

  def display_error(error_code)
    puts HangmanInputErrors.error_messages[error_code]
  end  

  def display_result(result_code)
    puts HangmanResults.result_messages[result_code]
  end

  def display_status(status_code)
    puts HangmanStatuses.status_messages[status_code]
  end

end









