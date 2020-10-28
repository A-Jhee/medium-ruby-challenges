# ------Meetup------

# Typically meetups happen on the same day of the week.

# Examples are

# the first Monday
# the third Tuesday
# the Wednesteenth
# the last Thursday
# Note that "Monteenth", "Tuesteenth", etc are all made up words. 
# There was a meetup whose members realised that there are exactly 
# 7 days that end in '-teenth'. Therefore, one is guaranteed that 
# each day of the week (Monday, Tuesday, ...) will have exactly one 
# date that is named with '-teenth' in every month.

# Write code that calculates date of meetups.

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ------Solution------

# 13th, 14th, 15th, 16th, 17th, 18th, 19th are the 7 days of the month
# that end in '-teenth'.

# class Meetup
#   def initalize(5, 2013)
#     @date = Date object with month and year
#       this creates 2013-05-01
#   end

#   def day(monday, condition)
#     LOOP (incrementor = 1)
#       if @date is monday
#         result << @date.day
#         incrementor = 7 //reassigned to 7 to get to next monday.
#       else
#         @date += incrementor
#       BREAK if @date.month == 6
#     END LOOP

#     result array [6th, 13th, 20th, 27th]

#     if :first result[0]
#     elsif :second result[1]
#     elsif :third result[2]
#     elsif :forth result[3]
#     elsif :last result[-1]
#     else :teenth result.select { |day| teenth_array.includes?(day) }

#     return Date.new(@date.year, @date.month, day)

#   end
# end

# How do you find the date given month, year and day of the week?
#   For example, year: 2013, month: 5, day: Monday.
#     - find and return [6th, 13th, 20th, 27th]
#   - create an instance method that calls Date#monday?, #tuesday? and so forth
#     have this instance method take a symbol to flow control
#     - I can use case statement
#     - or if...elsif statements
#     - or create instance methods #monday, #tuesday, and so forth.
#       method definition will be Date.monday?, Date.tuesday? and so forth.
#       I'll use Meetup.send(:monday) to call these instance methods.
#   - collect all dates that are true in an array

# How do I find the dates that match the day of the week AND special condition?
#   - use the array got from above logic, and validate by special condition
#   - 1st, 2nd, 3rd, 4th, last, easily done by indexing the array
#   - teenth will narrow the initial search field down to the 7 teenth days.
#     there will be only one day of the week within a certain month's teenth days. 
#     So return as soon as the desired day of the week is found from the teenth days.

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# My solution
require 'date'

class Meetup
  TEENTH_DAYS = [13, 14, 15, 16, 17, 18, 19]

  def initialize(month, year)
    @date = Date.new(year, month)
  end

  def day(wkday, schedule)
    possible_days = []
    year = @date.year
    month = @date.month

    while @date.month == month
      if is_today?(wkday)
        possible_days << @date.day
        @date += 7
      else
        @date += 1
      end
    end

    @date = Date.new(year, month, get_day(possible_days, schedule))
  end

  private

  def is_today?(wkday)
    case wkday
    when :monday    then @date.monday?
    when :tuesday   then @date.tuesday?
    when :wednesday then @date.wednesday?
    when :thursday  then @date.thursday?
    when :friday    then @date.friday?
    when :saturday  then @date.saturday?
    when :sunday    then @date.sunday?
    end
  end

  def get_day(days_arr, schedule)
    case schedule
    when :first   then days_arr[0]
    when :second  then days_arr[1]
    when :third   then days_arr[2]
    when :fourth  then days_arr[3]
    when :last    then days_arr[-1]
    when :teenth  then days_arr.select { |d| TEENTH_DAYS.include?(d) }[0]
    end
  end
end

# instructor solution

# class Meetup
#   STARTING_DAY = { first: 1, second: 8, third: 15, fourth: 22, last: -7, teenth: 13 }

#   def initialize(month, year)
#     @month = month
#     @year = year
#   end

#   def day(wkday, schedule)
#     starting_date = Date.new(@year, @month, STARTING_DAY[schedule])
#     (starting_date..(starting_date + 6)).detect { |date| date.public_send(wkday.to_s + '?') }
#   end
# end