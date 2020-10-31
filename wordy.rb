# -----Wordy-----

# Write a program that takes a word problem and returns the answer as an integer.

# ex) What is 5 plus 13?

# The program should return 18.

# ex) What is 7 minus 5 minus 1?

# The program should return 1.

# Remember, that these are verbal word problems, not treated as you normally would 
# treat a written problem. This means that you calculate as you move forward each step. This means 3 + 2 * 3 = 15, not 9.

# Hint: to solve this problem elegantly, you need to know how the send method works 
# in Ruby. If you haven't seen it before, check it out here.

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ------Solution------

# Obj: solve verbal math problems.

# - Follows the format:
#   - entire thing is given as single str
#   - first two words are "What is"
#   - ending character is "?"
#   - all words and numbers are separated by space: " ".
#   - operations are:
#     - "plus"
#     - "minus"
#     - "multiplied by"
#     - "divided by"
#   - expected return value is single integer (either positive or negative)

# class constructor takes the entire problem as a single str as one and only
#   argument

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ------Algorithm------

# 1) split str into tokens and collect into arr
#   - question.split(' ')
# 2) remove "What" and "is" and "by"
#   - remove tokens[0] and tokens[1] from arr
#   - tokens remove 'by'
# 3) remove "?" from the last array item
#   - taken tokens[-1].gsub!(/?/, '')
# 4) iterate over the rest of the tokens
#   - should only contain numbers (as str objects) and verbal operators
#   - match token against /[0-9]/ to find numbers, and convert to integer
#   - match token against one of four possible operators to convert to
#     string representation of operator symbols: "+", "-", "*", "/"
# 5) take the converted items, iterate from first number and use #send to
#    send operator method
#    ex) 25.send('+', 8)  => 25 + 8
# 6) return the resulting value of the calculation

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# class WordProblem
#   OPERATORS = ["plus", "minus", "multiplied", "divided"]

#   def initialize(question)
#     @question = question
#   end

#   def answer
#     tokens = sanitize_question

#     is_question_valid?(tokens)

#     result = tokens[0]
#     indx = 1

#     while indx < tokens.size
#       result = result.send(tokens[indx], tokens[indx+1])
#       indx += 2
#     end

#     result
#   end

#   private

#   def sanitize_question
#     tokens = @question.split(" ")[2..-1]
#     tokens.delete("by")
#     tokens[-1].gsub!(/\?/, "")
#     result = tokens.map do |token|
#       if token.match(/\d/)
#         token.to_i
#       else
#         get_operator(token)
#       end
#     end
#     result
#   end

#   def get_operator(str)
#     if str == OPERATORS[0]
#       "+"
#     elsif str == OPERATORS[1]
#       "-"
#     elsif str == OPERATORS[2]
#       "*"
#     elsif str == OPERATORS[3]
#       "/"
#     end
#   end

#   def is_question_valid?(tokens)
#     raise ArgumentError if !@question.match(/\d/)
#     raise ArgumentError if tokens.any? { |token| token.nil? }
#   end
# end

class WordProblem
  OPERATORS = { 'plus' => '+', 'minus' => '-',
                'divided' => '/', 'multiplied' => '*' }

  attr_accessor :operators, :numbers

  def initialize question
    @numbers = question.scan(/-?\d+/).map(&:to_i)
    @operators = question.scan(/plus|minus|divided|multiplied/)

    raise ArgumentError, "Question not recognized" if @numbers.empty? || @operators.empty?
  end

  def answer
    @operators.each_with_index.reduce(@numbers.first) do |result, (operator, idx)|
      result.send OPERATORS[operator], @numbers[idx + 1]
    end
  end
end

w = WordProblem.new('What is 20 minus 4 minus 13?')
w.answer
