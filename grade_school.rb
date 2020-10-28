# -----Grade School-----

# Write a small archiving program that stores students' names 
# along with the grade that they are in.

# In the end, you should be able to:

# Add a student's name to the roster for a grade
# "Add Jim to grade 2."
# "OK."

# Get a list of all students enrolled in a grade
# "Which students are in grade 2?"
# "We've only got Jim just now."

# Get a sorted list of all students in all grades. Grades should 
# sort as 1, 2, 3, etc., and students within a grade should be sorted 
# alphabetically by name.

# Copy Code
# {1=>["Anna", "Barb", "Charlie"], 2=>["Alex", "Peter"], ...}
# The exact output format doesn't matter: what's important is that it 
# shows all of the students and grades in the proper order.

# Note that all our students only have one name. (It's a small town, 
# what do you want?)

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# -----Solution-----

# According to the given accompanying test suite, it requires a new class 
# "School" with 3 instance methods:
#   - School#add(name, grade_number)
#     * takes two arguments, student's name and student's grade num.
#     * adds this info into the School class's attribute that tracks all grades
#       and students.
#     * Per specification, there will be no duplicate names, no need to validate
#   - School#to_h
#     * returns a hash where keys are grades and values are an array containing 
#       student names.
#     * the grades must be in numerical order, and names are in alphabetical order
#       ** Hash keys are ordered by order of insertion. I must either make it so 
#          that when adding new students, it orders itself within the class attr, or 
#          when invoking #to_h, unordered hash is ordered before returning.
#         - whenever adding a new student, after sure to reassign a sorted array after
#           appending new value
#         - before outputting hash, sort by keys.
#       ** array can be easily sorted using #sort
#   - School#grade(grade_number)
#     * takes on argument, grade number
#     * returns an array of all student names in that grade
#       ** if there is no one in that grade, return empty array.
#       ** make sure to not create an empty array as a value to this grade within hash

# -----Pseudo-Code-----

# attr_accessor student_hash

# School.new
#   student_hash = {}

# School.add(name, grade)
#   student_hash[grade] = name

# School.to_h
#   student_hash.sort.to_h

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# My solution
class School
  attr_reader :student_hash

  def initialize
    @student_hash = {}
  end

  def to_h
    @student_hash.sort.to_h
  end

  def add(name, grade_number)
    @student_hash[grade_number] = grade(grade_number).push(name).sort!
  end

  def grade(grade_number)
    @student_hash[grade_number].nil? ? [] : @student_hash[grade_number]
  end
end

# instructor solution

# class School
#   def initialize
#     @roster = Hash.new { |roster, grade| roster[grade] = [] }
#   end

#   def to_h
#     @roster.sort.to_h
#   end

#   def add(name, grade_num)
#     @roster[grade_num].push(name).sort!
#   end

#   def grade(grade_num)
#     @roster[grade_num]
#   end
# end