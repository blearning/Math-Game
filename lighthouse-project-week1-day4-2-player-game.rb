@player_one_name = ''
@player_one_lives = 3
@player_one_score = 0

@player_two_name = ''
@player_two_lives = 3
@player_two_score = 0

@player_turn = 1
@answer = 0
@round = 1

#reset_scores
def reset_scores
  @player_one_lives = 3
  @player_two_lives = 3
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

#lives_manager
def lives_manager
  if @player_turn == 1
    @player_one_lives -= 1
  else
    @player_two_lives -= 1
  end
  puts "Lives:\n#{@player_one_name}( \"#{@player_one_lives}\" )\n#{@player_two_name}( \"#{@player_two_lives}\" )"
end

#generate_question
def generate_question
  first_random_number = Random.new.rand(1..20) 
  second_random_number = Random.new.rand(1..20) 
  print "(Round #{@round}) its "
  if @player_turn == 1
    print "#{@player_one_name}'s Turn: " 
  else
    print "#{@player_two_name}'s Turn: "
  end
  print "#{first_random_number} + #{second_random_number} = #{first_random_number + second_random_number}\n"
  @answer = first_random_number + second_random_number
end

#verify_answer
def verify_answer(answer)
  if @answer == answer.to_i
    #playerscore
    puts "you win"
    player_scores_add_1(1)
  else
    #Sorry Message
    puts "you lose"
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

end

#start_game
def new_round
  prompt_player_names
  generate_question
  verify_answer(gets.chomp)
  next_player
end
new_round

# stop_game = true
# while stop_game
#   command = gets.chomp
#   case command
#   when "/\d*/" then verify_answer(gets.chomp)
#   when "q" then stop_game = true
#   end
# end
