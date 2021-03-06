require_relative '../view.rb'
require_relative '../model.rb'

RSpec.describe HangmanView do
  describe '#print_status' do
    let(:hangman) { HangmanModel.new('foo') }
    let(:view) { HangmanView.new(hangman) }

    context 'with no letters guessed' do
      it 'reveals no letters in the word' do
        expected_output = "\nhere's the word so far: "\
                          "***\n"\
                          "you have #{hangman.remaining_lives} "\
                          "lives remaining\n"
        expect { view.print_status }.to output(expected_output).to_stdout
      end
    end

    context 'with correct letters guessed' do
      it 'reveals correct letters in the word and used letters' do
        hangman.used_letters.push('o', 'b')

        expected_output = "\nhere's the word so far: "\
                          "*oo\n"\
                          "you have #{hangman.remaining_lives} "\
                          "lives remaining\n"\
                          "Letters you've guessed: o b\n"
        expect { view.print_status }.to output(expected_output).to_stdout
      end
    end
  end
end
