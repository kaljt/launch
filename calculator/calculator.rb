require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
puts MESSAGES.inspect
OPS = %w(Zero Adding Subtracting Multiplying Dividing)
DIGITS = *(0..9)

def prompt(message)
  Kernel.puts("=>  #{message}")
end

def valid_number?(number)
  number.to_i.to_s == number || number.to_f.to_s == number
end

prompt(MESSAGES['welcome'])
name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt('Make sure to use a valid name.')
  else
    break
  end
end
prompt("Hi #{name}")

loop do
  number1 = ''
  number2 = ''
  loop do
    prompt(MESSAGES['number1'])
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt(MESSAGES['invalid'])
    end
  end
  loop do
    prompt(MESSAGES['number2'])
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt(MESSAGES['invalid'])
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
    MSG

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['menu'])
    end
  end

  prompt("#{OPS[operator.to_i]} the two numbers...")

  result = case operator
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
           end

  prompt("The result is #{result}")

  prompt(MESSAGES['continue'])
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end
prompt(MESSAGES['goodbye'])
