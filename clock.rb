# -----Clock-----

# Create a clock that is independent of date.

# You should be able to add and subtract minutes to it. 
# Two clocks that represent the same time should be equal to each other.

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ------Solution------

# Clock class method #at() takes 2 arguments (hour, minute=0) minutes default to 0 min
# hours from 00 (midnight) to 23 (11pm) ** military time
#   - be sure to have the hours wrap around: 23:00 + 60 will be 00:00
#     and 00:30 - 60 will be 23:30
#   for example, Clock.at(8).to_s will give 8:00
#   this class method #at() returns a Clock object instance, that can take
#   #to_s instance method

# #to_s will give string formatted in '07:01'

# Clock object also has instance method #+() that takes one int argument
# - indicates how many minutes to move the time forward.
#   - +60 is + 1 hour
# Similarly #-() moves the time backwards by given minutes.

# Also needs instance method #==() to compare two Clock objects
# it should make value comparison on hour and minutes.
#   instance varibles @hour @min stored as int
#   compare hour to hour and min to min

# ** What logic will allow for the military time to wrap itself around time
#    addition and subtraction?
#   - when adding time (time moving forward), make addition and then perform
#      modulo operation on the hour (ex. 26 % 24) to get the wrap-around hour
#   - when removing time (time moving backwards), make subtraction. check to see
#     if hours are negative. If so, set hour to negative hours + 24.
#     ex) t = t < 0 ? t+24 : t
# 15 - 45 min = -30

class Clock
  attr_reader :hour, :min

  def initialize(hour, min)
    @hour = hour
    @min = min
  end

  def self.at(hour, min=0)
    Clock.new(hour, min)
  end

  def to_s
    "%02d:%02d" % [@hour, @min]
  end

  def ==(other_clock)
    @hour == other_clock.hour && @min == other_clock.min
  end

  def +(minutes)
    hour_min_arr = split_mins_to_hour_min(minutes)
    @hour = (@hour + hour_min_arr[0]) % 24
    @min += hour_min_arr[1]
    self
  end

  def -(minutes)
    hour_min_arr = split_mins_to_hour_min(minutes)
    @hour = (@hour - hour_min_arr[0])
    @hour = (@hour < 0) ? (@hour + 24) : @hour
    @min = (@min - hour_min_arr[1])
    if @min < 0
      @hour -= 1
      @min *= -1
    end
    self
  end

  private

  def split_mins_to_hour_min(minutes)
    result = []
    if minutes > 60
      result << minutes / 60
      result << minutes % 60
    elsif minutes == 60
      result = [1, 0]
    else
      result = [0, minutes]
    end
    result
  end
end

