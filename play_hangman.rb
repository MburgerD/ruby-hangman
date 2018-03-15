require_relative 'model'
require_relative 'view'
require_relative 'controller'


hangman_model = HangmanModel.new(word='Hangman', remaining_lives=5)
hangman = GameController.new(hangman_model, HangmanView.new(hangman_model))
hangman.play