require_relative 'model'
require_relative 'view'
require_relative 'controller'


hangman_model = HangmanModel.new
hangman = GameController.new(hangman_model, HangmanView.new(hangman_model))
hangman.play