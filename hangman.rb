class HangmanGame
	def initialize(word)
		print `clear`
		puts "------------------hangman------------------"
		@word = word
		@used_letters = []
		@correct_letters = []  # store in lower case
		@remaining_lives = 5
		@game_over = false

	end

	attr_reader :game_over

	def take_turn
		print_status
		
		validated_input = nil
		# get input from player
		while not validated_input
			input = player_input
			validated_input = validate_input(input)
		end

		@used_letters.push(validated_input)

		if guess_is_correct(validated_input)
			puts "Correct!"
			@correct_letters.push(validated_input)
			print_word_progress
		else
			puts "Damn, the word does not contain #{validated_input}!"
			deduct_life
		end

		if no_lives_remaining
			puts "\n\nGame over, you've run out of lives!"
			puts "The word was #{@word}"
			@game_over = true
		elsif all_letters_guessed
			puts "\n\nWell done, you got it!"
			@game_over = true
		end

		print "\n"
	end

	def deduct_life
		@remaining_lives -= 1
	end

	def guess_is_correct(char)
		return @word.downcase.include? char
	end

	def validate_input(raw_input)
		if not one_character_entered(raw_input)
			puts "You must only enter one letter"
			return
		end
		if not character_is_alpha(raw_input)
			puts "You must enter a letter"
			return
		end
		input_lower_case = raw_input.downcase
		if already_chosen_letter(input_lower_case)
			puts "You've already guessed that letter"
			return
		end
		return input_lower_case
	end

	def one_character_entered(input)
		return input.length == 1
	end

	def character_is_alpha(char)
		return /^[[:alpha:]]$/ === char
	end

	def already_chosen_letter(char)
		return @used_letters.include? char
	end

	def print_status
		print "here's the word so far: "
		print_word_progress
		puts "you have #{@remaining_lives} lives remaining"
		print_used_letters
	end

	def print_word_progress
		@word.each_char do |i|
			if @correct_letters.include? i.downcase
				print i
			else
				print "*"
			end
		end
		print "\n"
	end

	def print_used_letters
		if @used_letters
			@used_letters.join(" ")
		end
	end

	def player_input
		print "Enter your guess >> "
		return gets.chomp
	end
		
	def no_lives_remaining
		return @remaining_lives == 0
	end

	def all_letters_guessed
		return @word.downcase.split('').uniq.length == @correct_letters.uniq.length
	end
		

end


hangman = HangmanGame.new('Timetable')
while not hangman.game_over
	hangman.take_turn
end




