# -----Nth Prime-----

# Write a program that can tell you what the nth prime is.

# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see 
# that the 6th prime is 13.

# Do not use Ruby's Prime class nor any of the prime-number testing methods 
# in the Integer class. For an algorithm to determine whether a number is 
# prime, check out this article.

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ------Solution------

# There is one class method to write Prime.nth(n).
# It returns the Nth prime number.
# ex) first prime is 2, second is 3, sixth is 13.

# Simplest solution would be, 
# iterate through all positive integer. Check each number for it's prime-ness
# when a prime number is found, increment counter by 1
# stop iterating when counter == n. and return that integer.

# ** potential problem **
#  There is a problem of efficiency. As the n gets larger, there will be a lot of
#  numbers to test for it's prime-ness.

# - How can i reduce the total number of integers to test for prime-ness?
#   + after number 2. No prime number can be a factor of 2. Therefore all primes
#     after 2 are odd numbers.
#     -TEST ONLY ODD NUMBERS AFTER 2 (start checking from 3, only odds)
#      +cuts total numbers to test by half

#   ** if the number to test is large (ex 12345), the square root is going to be large
#      and there will be equally numerous prime numbers upto that square root.
#      - finding the prime numbers upto that square root, repeats the process of
#        testing all numbers upto square root value and finding primes.
#      - doubling over the process: can it be made better?

# - How do i test for prime-ness?
#   + Follow the given algo:
#     -calculate square root of a number.
#     -round down to nearest integer
#     // -get all prime numbers upto integer got from above //
#     -if none of them are a factor to given number, it is prime.

# first 25 prime numbers can be found on wikipedia. can easily set all 25 primes
# as a class constant and return from them for prime numbers under 100.

# - What about prime numbers that are greater than 100?

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# def nth_prime(n)
#   return 2 if n == 1
#   return 3 if n == 2

#   primes = [2, 3]
#   test_num = primes[-1]
#   counter = 2

#   while primes.length < n
#     test_num += 2
#     upper_test_limit = Math.sqrt(test_num).floor
#     test_factors = primes.select { |prime| prime <= upper_test_limit }
#     if is_prime?(test_num, test_factors)
#       primes << test_num
#       counter += 1
#     end
#   end
#   primes[-1]
# end



class Prime
  def self.nth(n)
    raise ArgumentError if n == 0
    return 2 if n == 1
    return 3 if n == 2

    primes = [2, 3]
    test_num = primes[-1]

    while primes.length < n
      test_num += 2
      upper_test_limit = Math.sqrt(test_num).floor
      test_factors = primes.select { |prime| prime <= upper_test_limit }
      if self.is_prime?(test_num, test_factors)
        primes << test_num
      end
    end
    primes[-1]
  end

  private

  def self.is_prime?(n, prime_factors)
    prime_factors.each do |factor|
      if n % factor == 0
        return false
      end
    end
    true
  end
end