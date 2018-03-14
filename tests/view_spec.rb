require_relative '../view.rb'
require_relative '../model.rb'


RSpec.describe HangmanView do 
  
  describe "#print_word_progress" do
    it "shows the letters which have been guessed correctly" do
      hangman = HangmanModel.new(word='foo')
      puts hangman.word
      view = HangmanView.new(hangman)
      expect{view.print_word_progress}.to output("***\n").to_stdout
      hangman.correct_letters << "o"
      expect{view.print_word_progress}.to output("*oo\n").to_stdout
    end
  end

  describe "#print_used_letters" do
    it "shows the letters which have been used" do
      hangman = HangmanModel.new
      puts hangman.word
      view = HangmanView.new(hangman)
      expect{view.print_used_letters}.to output("").to_stdout
      hangman.used_letters.push("a", "b")
      expect{view.print_used_letters}.to output("Letters you've guessed: a b\n").to_stdout
    end
  end

end