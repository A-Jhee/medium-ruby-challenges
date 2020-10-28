# -----Phone Number-----

# Write a program that cleans up user-entered phone numbers so that they can be sent as SMS messages.

# The rules are as follows:

# If the phone number is less than 10 digits assume that it is bad number
# If the phone number is 10 digits assume that it is good
# If the phone number is 11 digits and the first number is 1, trim the 1 and use the last 10 digits
# If the phone number is 11 digits and the first number is not 1, then it is a bad number
# If the phone number is more than 11 digits assume that it is a bad number

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ------Solution------

# Valid Input
#  - 10 digits
#  - 11 digits where first number is 1

# Invalid Input
#  - less than 10 digits
#  - 12 digits and greater
#  - 11 digits but first number is NOT 1
#  - any letters

# When given valid input, store as 10 digit number, stripped of
# any special characters, such as parenthesis, periods, dashes, etc.

# PhoneNumber#number returns the 'pure' 10 digit number.

# PhoneNumber#to_s returns 'formatted' number:
#   (555) 555-5555

# strip initial input of any non-alphanumeric characters, then validate


# if num.length < 10
#   return '0000000000'
# elsif num.length > 11
#   return '0000000000'
# elsif num.chars.match( alphabet )
#   return '0000000000'
# elsif num.length == 11 && num[0] != 1
#   return '0000000000'
# elsif num.length == 11 && num[0] == 1
#   return num[1..-1]
# else
#   return num

# '(#{num[0..2]}) #{num[3..5]}-#{num[6..-1]}'

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ------My Solution------

class PhoneNumber
  attr_reader :number

  def initialize(phone_num_str)
    @number = validate(phone_num_str.gsub(/[^a-zA-Z0-9]/, ''))
  end

  def area_code
    @number[0..2]
  end

  def to_s
    "(#{area_code}) #{@number[3..5]}-#{@number[6..-1]}"
  end

  private

  def validate(stripped_phone_num_str)
    if stripped_phone_num_str.length == 11 && stripped_phone_num_str[0] == '1'
      return stripped_phone_num_str[1..-1]
    elsif stripped_phone_num_str.length == 10 && !stripped_phone_num_str.match(/[a-zA-Z]/)
      return stripped_phone_num_str
    else
      return '0000000000'
    end
  end
end

