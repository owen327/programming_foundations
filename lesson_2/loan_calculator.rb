def prompt(message)
  puts("=> #{message}")
end

def get_valid_number
  loop do
    input = gets.chomp
    if /\d/.match(input) && /^\d*\.?\d*$/.match(input)
      return input.to_f
    else
      prompt "Please enter a positive number."
    end
  end
end

def calculate_monthly_payment(l, c, n)
  l * (c / (1 - (1 + c)**-n))
end

system 'clear'

prompt "Welcome to the Loan Calculator!".center(80, "*")

loop do
  prompt "What is the total loan amount?"
  amount = get_valid_number

  prompt "What is the APR? in %"
  interest_rate = get_valid_number

  prompt "What is the loan duration in years?"
  years = get_valid_number

  annual_interest_rate = interest_rate / 100
  monthly_interest_rate = annual_interest_rate / 12
  months = years * 12

  prompt "Your monthly payment is: $#{calculate_monthly_payment(amount, monthly_interest_rate, months).round(2)}"

  prompt "Do you want to perform another calculation? (Y to calculate again)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for using the Loan calculator!".center(80, "*")
prompt "Good bye!".center(80, "*")
