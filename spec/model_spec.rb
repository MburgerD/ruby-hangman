require_relative '../model.rb'
require_relative '../view.rb'

RSpec.describe HangmanModel do
  describe '#take_turn' do
    let(:hangman) { HangmanModel.new('foo', 5) }

    context 'with incorrect letter' do
      it 'returns correct error code, deducts life' do
        expect(hangman.take_turn('q')).to eq([HangmanResults::INCORRECT_GUESS])
        expect(hangman.remaining_lives).to eq(4)
      end
    end

    context 'with correct letter' do
      it 'returns correct error code, does not deduct life' do
        expect(hangman.take_turn('o')).to eq([HangmanResults::CORRECT_GUESS])
        expect(hangman.remaining_lives).to eq(5)
      end
    end

    context 'with correct letter capitalised' do
      it 'returns correct error code, does not deduct life' do
        expect(hangman.take_turn('F')).to eq([HangmanResults::CORRECT_GUESS])
        expect(hangman.remaining_lives).to eq(5)
      end
    end
  end

  describe '#turn_input_error_codes' do
    let(:hangman) { HangmanModel.new }

    context 'with single number' do
      it 'returns correct error code' do
        expect(hangman.turn_input_error_codes('1')).to \
          eq([HangmanInputErrors::NOT_ALPHA])
      end
    end

    context 'with multiple non-alphas' do
      it 'returns correct error codes' do
        expected_error_codes = [HangmanInputErrors::MULTIPLE_CHARACTERS,
                                HangmanInputErrors::NOT_ALPHA]
        expect(hangman.turn_input_error_codes('1@q')).to \
          eq(expected_error_codes)
      end
    end

    context 'with a single, used letter' do
      it 'returns correct error code' do
        hangman.used_letters << 'a'

        expect(hangman.turn_input_error_codes('a')).to \
          eq([HangmanInputErrors::USED_LETTER])
      end
    end

    context 'with a single, unused letter' do
      it 'returns empty array' do
        expect(hangman.turn_input_error_codes('a')).to eq([])
      end
    end
  end
end
