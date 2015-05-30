class Game

  def initialize()
    @player_1 = ''
    @player_2 = ''

    @play = true
    @player_turn = 1
    @round = 1
    @answer = 0
  
  end

  def initialize_players
    if @player_1 == '' && @player_2 == ''
      print "Player 1 Name:\n> "
      @player_1 = Player.new(gets.chomp)

      print "Player 2 Name:\n> "
      @player_2 = Player.new(gets.chomp)
    end
    
  end

  def reset_score_and_round
    @player_1.lives = 3
    @player_2.lives = 3
    @round = 1
  end

  #next_player
  def next_player
    if @player_turn == 1
      @player_turn = 2
    else
      @player_turn = 1
    end
  end
  #next_round
  def next_round
    @round += 1
  end

  #check players lives
  def check_life
    if @player_one_lives == 0 || @player_two_lives == 0
      return false 
    else
      return true
    end
  end

  #player_scores
  def player_scores_add_1(points)
    if @player_turn == 1
      puts  @player_1.score += 1
    else
      @player_2.score += 1
    end
    puts "Scores:\n#{@player_1.name}( \"#{@player_1.score}\" )\n#{@player_2.name}( \"#{@player_2.score}\" )"
  end
  #lives manager
  def lives_manager
    if @player_turn == 1
      @player_1.lives -= 1
    else
      @player_2.lives -= 1
    end
    puts "Lives:\n#{@player_1.name}( \"#{@player_1.lives}\" )\n#{@player_2.name}( \"#{@player_2.lives}\" )"
  end

  #verify_answer
  def verify_answer(answer)
    if @answer == answer.to_i
      #playerscore
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~~~~~~~~CORRECT ANSWER~~~~~~~~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      player_scores_add_1(1)
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"
    else
      #Sorry Message
      puts "~~~~~~~~~~~~WRONG ANSWER~~~~~~~~~~~~"
      lives_manager
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"
    end
  end

  def message_whos_turn?
    print "\n****************************\n******** (Round #{@round}) *********\n"
    if @player_turn == 1
      
      print "#{@player_1.name}'s Turn: "
    else
      print "#{@player_2.name}'s Turn: "
    end
  end

  def run_game
    #trying out the recursive method that all the hipsters are talking about
    return if @player_1.lives == 0 || @player_2.lives == 0
    questions = Questions.new
    message_whos_turn?
    questions.generate_question
    @answer = questions.answer.to_i
    print "> "
    verify_answer(gets.chomp)
    next_round
    next_player
    run_game
  end

  #choose_winner
  def choose_winner
    if @player_1.lives < @player_2.lives
      puts "#{@player_1.name} is the WINNER!"
    else
      puts "#{@player_2.name} is the WINNER!"
    end
  end

  # prompt_for_new_game
  def prompt_for_new_game

  understandable_user_prompt = true

  while understandable_user_prompt

    puts "Want to start a new Game? (Y/N)"
    print "> "
    command = gets.chomp

    case command
      when "Y", "y" 
      puts "~~~~~~~~~~~~\nNew Game!\nIt's #{@player_1.name} vs #{@player_2.name}\n~~~~~~~~~~~~\n"
      understandable_user_prompt = false
      reset_score_and_round
      start
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


  #start
  def start
    initialize_players
    #run_game is recursive 
    run_game
    choose_winner
    prompt_for_new_game
  end

end