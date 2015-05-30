class Questions

  attr_reader :answer

  def initialize
    @answer = 0
    @operations = ['+','-','*']
  end

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

  def generate_question
    randomized_operation = operation_generator
    first_random_number = Random.new.rand(1..20) 
    second_random_number = Random.new.rand(1..20) 
    print "#{first_random_number} #{randomized_operation} #{second_random_number} = ?\n"
    @answer = operation_magic(randomized_operation, first_random_number, second_random_number) 
  end
  

end



