require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def integer?(input)
  /^\d+$/.match(input)
end

def float?(input)
  /\d/.match(input) && /^\d*\.?\d*$/.match(input)
end

def valid_number?(num)
  integer?(num) || float?(num)
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt MESSAGES['welcome']

name = ''
loop do
  name = gets.chomp.capitalize

  if name.empty?
    prompt MESSAGES['valid_name']
  else
    break
  end
end

prompt MESSAGES['hi'] + name + "!"

loop do # main loop
  number1 = ""
  loop do
    prompt MESSAGES['prompt_number1']
    number1 = gets.chomp

    if valid_number?(number1)
      break
    else
      prompt MESSAGES['valid_number']
    end
  end

  number2 = ""
  loop do
    prompt MESSAGES['prompt_number2']
    number2 = gets.chomp

    if valid_number?(number2)
      break
    else
      prompt MESSAGES['valid_number']
    end
  end

  # operator_prompt = <<-MSG
  #   What operation would you like to perform?
  #   1) add
  #   2) subtract
  #   3) multiply
  #   4) divide
  # MSG

  # prompt(operator_prompt)
  prompt MESSAGES['operator_prompt']

  operator = ''
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt MESSAGES['valid_operator']
    end
  end

  prompt operation_to_message(operator) + MESSAGES['operation']

  result = case operator
           when "1"
             number1.to_f + number2.to_f
           when "2"
             number1.to_f - number2.to_f
           when "3"
             number1.to_f * number2.to_f
           when "4"
             number1.to_f / number2.to_f
           end

  prompt MESSAGES['result'] + result.to_s

  prompt MESSAGES['again']
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt MESSAGES['good_bye']
