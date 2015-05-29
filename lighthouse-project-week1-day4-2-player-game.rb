@player_one_name = ''
@player_one_lives = 3
@player_one_score = 0

@player_two_name = ''
@player_two_lives = 3
@player_two_score = 0

@play = true
@player_name_isset = 0
@player_turn = 1
@answer = 0
@round = 0

#operations used in questions
@operations = ['+','-','*']

#reset_scores
def reset_score_and_round
  @player_one_lives = 3
  @player_two_lives = 3
  @round = 0
end

#player_scores
def player_scores_add_1(points)
  if @player_turn == 1
    @player_one_score += 1
  else
    @player_two_score += 1
  end
  puts "Scores:\n#{@player_one_name}( \"#{@player_one_score}\" )\n#{@player_two_name}( \"#{@player_two_score}\" )"
end

#player_results
def player_results
  if @player_one_lives < @player_two_lives
    puts "#{@player_two_name} is the WINNER!"
  else
    puts "#{@player_one_name} is the WINNER!"
  end
end

#lives_manager
def lives_manager
  if @player_turn == 1
    @player_one_lives -= 1
  else
    @player_two_lives -= 1
  end
  puts "Lives:\n#{@player_one_name}( \"#{@player_one_lives}\" )\n#{@player_two_name}( \"#{@player_two_lives}\" )"
end

#check players lives
def check_life
  if @player_one_lives == 0 || @player_two_lives == 0
    return false 
  else
    return true
  end
end

#operation_generator
def operation_generator
  length_of_array = @operations.length
  return @operations[Random.new.rand(0..length_of_array-1)]
end

def operation_magic(operator, num1, num2)
  operator = operator
  case operator
  when "-" then num1 - num2
  when "+" then num1 + num2
  when "*" then num1 * num2
  end
end

#generate_question
def generate_question
  randomized_operation = operation_generator
  first_random_number = Random.new.rand(1..20) 
  second_random_number = Random.new.rand(1..20) 
  print "(Round #{@round}) its "
  if @player_turn == 1
    print "#{@player_one_name}'s Turn: " 
  else
    print "#{@player_two_name}'s Turn: "
  end
  print "#{first_random_number} #{randomized_operation} #{second_random_number} = ?\n"
  @answer = operation_magic(randomized_operation, first_random_number, second_random_number) 
end

#verify_answer
def verify_answer(answer)
  if @answer == answer.to_i
    #playerscore
    puts "~~~~CORRECT ANSWER~~~~~"
    player_scores_add_1(1)
  else
    #Sorry Message
    puts "~~~~WRONG ANSWER~~~~~"
    lives_manager
  end
end

#next_player
def next_player
  if @player_turn == 1
    @player_turn = 2
  else
    @player_turn = 1
  end
end

#promt_player_for_names
def prompt_player_names
  print "Player 1 Name: "
  @player_one_name = gets.chomp
  print "Player 2 Name: "
  @player_two_name = gets.chomp
  @player_name_isset = 1
end

#prompt_for_new_game
def prompt_for_new_game

  understandable_user_prompt = true

  while understandable_user_prompt

    puts "Want to start a new Game? (Y/N)"
    print "> "
    command = gets.chomp

    case command
    when "Y", "y" 
    puts "New Game!\nIt's #{@player_one_name} vs #{@player_two_name}\n"
    understandable_user_prompt = false
    reset_score_and_round
    when "N", "n"
    understandable_user_prompt = false
    @play = false
    puts "."
    puts ".."
    puts "..."
    puts "...Bye"
    when /.*/
    puts "Sorry, I don't understand!"
    end
  end
end

#start_game
def new_round
  @round += 1
  prompt_player_names if @player_name_isset == 0
  generate_question
  print "> "
  verify_answer(gets.chomp)
  next_player
end

#turn_on_machine
def turn_on_machine
  @play = true
  while @play
    if check_life
      new_round
    else
      player_results
      prompt_for_new_game
    end
  end
end

turn_on_machine