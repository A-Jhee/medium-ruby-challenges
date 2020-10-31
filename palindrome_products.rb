# -----Palindrome Products-----

# Write a program that can detect palindrome products in a given range.

# A palindromic number reads the same both ways. The largest palindrome 
# made from the product of two 2-digit numbers (range 10 ~ 99) is 9009 = 91 x 99.

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ------Solution------

# Palindromes.new(max_factor, min_factor=1)

# constructor takes upto two arguments (two integers).
# min_factor has a default value of 1

# these two integers make up the upper and lower limits of factors that can be used
# to multiply to find a numeric palindrome (number that is read same from front and 
# from back)

# Palindromes objects have 
# - #generate instance method
# - #largest instance method
#   - this returns the largest palindrome product and its factors
#   - this method returns a data structure that allows me to call #value,
#      # factors on it.
#     - #largest most likely returns a hash. it makes it so that calling 
      #values returns the same data structure as calling #factors.

=begin

largest palindrome can have multiple factors. For example '9' is a largest
single digit palindrome (all single digit integers are palindromes).

integer factors for 9 that are single digit:
[1, 3, 9]

and this produces [ [3, 3], [1, 9] ] AND [ [1, 9], [3, 3] ]
these arrays can be found if iterating through each factors to find 
the product that will equal '9'. while interating, do not consider the
last factor. (considering last factor would have given [9, 1] as one of the
possible factor pairs in the answer)

result = []
[1, 3, 9][0..-2].each do |factor|
  arr = [factor]
  other_factor = largest (which is 9) / factor
  arr << other_factor
  result_arr < arr [1, 9]
end

result_arr = [ [1, 9], [3, 3] ]

[1, 3, 9][0..-2].reverse  (which is [3, 1])
.each do (same logic as above)
  this gives: result_arr [ [3, 3], [1, 9] ]

if I take both results into an array

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-----How do I find a palindrome product?

If given a range of 10~99 to find all palindrome products, I can 
iterate through each number and multiply all other numbers and then test
each product for palindrome.
  - This poses an efficiency problem, (potential 8100 calculations)

-----How can I make this better?

- reduce the number of test cases
- know what palindromes to test (is it possible?)
  
  * going through all numbers to find palindromes
  - iterate thru all positive integers. test for palindrome, if found
    find its integer factors.
  - once one of the factors to a palindrome is larger than the max factor
    break iteration.

  * create a palindrome constructor
  - lower testing limit for palindrome will be min_factor**2
  - upper testing limit for palindrome will be max_factor**2
    ex) 10~99. LTL = 10**2 = 100.  UTL = 99**2 = 9801
  - I can create palindrome number by working outside in. 
    1 x x x x x 1
    1 4 x x x 4 1
    1 4 3 x 3 4 1
    1 4 3 0 3 4 1
  - if 3 digits, possible palindromes are 90
  - if 4 digits, possible palindromes are 90
    1 x x 1
  - if 5 digits, possible palindromes are 900
    1 x x x 1

-----How do I test for palindrome number?

convert number to string. call chars to get char array.
compare itself to its reverse order array.

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-----Algorithm

palindromes = Palindromes.new(max_factor: 99, min_factor: 10)
>>>> palindromes is object with @max_factor=99, @min_factor=10

palindromes.generate
>>>> array of all palindromes that has factors from 10 upto 99

- find the palindrome that comes immediately after min_factor**2
- starting from that palindrome, construct all palindromes upto 
  max_factor**2, collect into an array
  - create number from taking the first digit of lower limit(LL)
    and making it also the last digit. ex) LL = 103   new_num = 101
    *when even number of digits
    - make 2nd digit the 2nd to last digit and so forth
    *when odd
    - keep the middle number as is.
  - see if it is larger than LL
    - if so this is next_plaindrome
  - if smaller, make next largest palindrome
    - take the inner most pair (or the middle num) and increment by 1
    - test again to see if larger that LL
    - loop until it does.
- iterate thru this array and check if it has factors within the boundaries
  set by min_factor and max_factor. if so, collect into another array

  arr.each do |palindrome|
    if factors.any? do |factor|
      palindrome % factor == 0 && (palindrome / factor).chars.size == 2
    end
      result << palindrome
    end
  end

- resulting array is the return value

=end

class Palindrome
  attr_reader :value, :factors

  def initialize(value, factors)
    @value = value
    @factors = factors
  end
end


class Palindromes
  attr_accessor :max_factor, :min_factor

  def initialize(factors_hash)
    @max_factor = factors_hash[:max_factor]
    @min_factor = factors_hash[:min_factor] ? factors_hash[:min_factor] : 1
    @palindrome_factors = []
  end

  def generate
    @palindrome_factors = find_all_palindromes
  end

  def largest
    product = 0
    factors = []

    @palindrome_factors.each do |f| 
      temp = f[0] * f[1]
      if temp > product
        product = temp
        factors = [f]
      elsif temp == product
        factors << f
      end
    end

    Palindrome.new(product, factors)
  end

  def smallest
    product = @max_factor**2
    factors = []

    @palindrome_factors.each do |f| 
      temp = f[0] * f[1]
      if temp < product
        product = temp
        factors = [f]
      elsif temp == product
        factors << f
      end
    end

    Palindrome.new(product, factors)
  end

  private

  def find_all_palindromes
    result = []
    starting_num = @min_factor

    while starting_num <= @max_factor
      (starting_num..@max_factor).each do |factor|
        if is_palindrome?(starting_num * factor)
          result << [starting_num, factor]
        end
      end
      starting_num += 1
    end

    result
  end

  def is_palindrome?(n)
    n.to_s == n.to_s.reverse
  end
end

# pal = Palindromes.new(max_factor: 9)
# pal.generate
# largest = pal.largest
# p largest.value
# p largest.factors

#   private

#   def find_all_palindromes
#     lower_limit = immediate_palindrome
#     upper_limit = @max_factor**2

#     new_palindrome = lower_limit
#     result = [new_palindrome]

#     until new_palindrome > upper_limit
#       new_palindrome = next_palindrome(new_palindrome)
#       result << new_palindrome
#     end

#     result
#   end

#   def immediate_palindrome
#     lower_limit = @min_factor**2
#     digits = lower_limit.to_s.chars
#     max_ind = digits.size / 2
    
#     if digits.size.even?
#       (0..max_ind-1).each do |ind|
#         digits[-(ind + 1)] = digits[ind]
#       end
#     else
#       (0..max_ind).each do |ind|
#         digits[-(ind + 1)] = digits[ind]
#       end
#     end
    
#     result = digits.join('').to_i 
    
#     while result < lower_limit
#       result = next_palindrome(result)
#     end

#     result
#   end

#   def find_palindromes_within_min_max(arr)
#     foo
#   end

#   def next_palindrome(palindrome)
#     digits = palindrome.to_s.chars
#     size = digits.size

#     ind = (size / 2).to_i
#     deviation = size.even? ? 1 : 0

#     digit_pair_left(ind, deviation)

#     while digits[ digit_pair_left(ind, deviation) ].to_i == 9
#       digits[ digit_pair_left(ind, deviation) ] = '0'
#       digits[ digit_pair_right(ind, deviation, size.even?) ] = '0'
#       deviation += 1
#       break if deviation > ind
#     end

#     return palindrome if deviation > ind

#     next_digit = digits[ digit_pair_left(ind, deviation) ].to_i + 1

#     digits[ digit_pair_left(ind, deviation) ] = next_digit.to_s
#     digits[ digit_pair_right(ind, deviation, size.even?) ] = next_digit.to_s

#     digits.join('').to_i
#   end

#   def digit_pair_left(ind, dev)
#     ind - dev
#   end

#   def digit_pair_right(ind, dev, pairty)
#     if pairty  # when even
#       ind + (dev - 1)
#     else       # when odd
#       ind + dev
#     end
#   end
# end