# First thing's first, lets pop these students into a cheeky array
students = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]
def print_header
  puts "The students of Villains Academy".center(100)
  puts "--------------------------------".center(100)
end

def print(students)
  count = 0
  while count < students.length do
    if students[count][:name][0] == "A" && students[count][:name].length < 12
      puts "#{count + 1} #{students[count][:name]} (#{students[count][:cohort]} cohort). Hobbies are #{students[count][:hobbies]} and hair colour is #{students[count][:hair]}".center(100)
    end
    count += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(100)
end

def input_students
  students = []
  puts "Please enter the name of the student"
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get the first student
    puts "Please enter the cohort of the student"
    cohort = gets.chomp
    cohort = "January" if cohort.empty?
    puts "Please enter the hobbies of the student"
    hobbies = gets.chomp
    puts "Please enter the hair colour of the student"
    hair = gets.chomp
    students << {name: name, cohort: cohort.to_sym, hobbies: hobbies, hair: hair}
    puts "Now we have #{students.count} students"
    puts "To finish, just hit return, or enter another name to carry on adding students"
    name = gets.chomp
  end
  # return the array of input_students
  students
end

students = input_students
print_header
print(students)
print_footer(students)
