
class HangmanResults
  @CORRECT_GUESS = 1
  @INCORRECT_GUESS = 2

  @result_messages = {@CORRECT_GUESS => "Correct!",
                      @INCORRECT_GUESS => "Nope! You lose a life!"}
  class << self
    attr_reader :CORRECT_GUESS, :INCORRECT_GUESS, :result_messages
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
    attr_reader :MULTIPLE_CHARACTERS, :NOT_ALPHA, :USED_LETTER, :error_messages
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
    print "\nhere's the word so far: "
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

  def game_won
    puts "Well done, you won!"
  end

  def game_lost
    puts "Oh no, you've lost!"
    reveal_word
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

end
