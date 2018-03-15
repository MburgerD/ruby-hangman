require_relative '../model.rb'

RSpec.describe HangmanModel do

  describe "#deduct_life" do
    it "subtracts 1 from @remaining_lives" do
      hangman = HangmanModel.new(word="foo", remaining_lives=10)
      expect(hangman.remaining_lives).to eq(10)
      hangman.deduct_life
      expect(hangman.remaining_lives).to eq(9)
    end
  end  

  describe "#letter_used" do
    it "returns true if letter in @used_letters, else false" do
      hangman = HangmanModel.new
      hangman.used_letters << 'a'
      expect(hangman.letter_used('a')).to be true
      expect(hangman.letter_used('b')).to be false
    end
  end  

  describe "#letter_in_word" do
    it "returns true if letter in @word, else false" do
      hangman = HangmanModel.new(word="foo")
      expect(hangman.letter_in_word('f')).to be true
      expect(hangman.letter_in_word('a')).to be false
    end
  end

    describe "#one_character_entered" do
    it "returns true if length of input is 1, else false" do
      hangman = HangmanModel.new
      expect(hangman.one_character_entered('f')).to be true
      expect(hangman.one_character_entered('foo')).to be false
    end
  end

    describe "#character_is_alpha" do
    it "returns true if input is a letter, else false" do
      hangman = HangmanModel.new
      expect(hangman.character_is_alpha('a')).to be true
      expect(hangman.character_is_alpha('A')).to be true
      expect(hangman.character_is_alpha('1')).to be false
      expect(hangman.character_is_alpha('@')).to be false
    end
  end

    describe "#no_lives_remaining" do
    it "returns true if @remaining_lives is 0, else false" do
      hangman = HangmanModel.new
      expect(hangman.no_lives_remaining).to be false
      hangman = HangmanModel.new(word='foo', remaining_lives=0)
      expect(hangman.no_lives_remaining).to be true
    end
  end    

  describe "#all_letters_guessed" do
    it "returns true if all letters in word are in @correct_letters" do
      hangman = HangmanModel.new(word='foo')
      expect(hangman.all_letters_guessed).to be false
      hangman.correct_letters << 'f'
      hangman.correct_letters << 'o'
      expect(hangman.all_letters_guessed).to be true
    end
  end

end