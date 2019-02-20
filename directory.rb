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

def get_input(string_message, default_value)
  user_input = ""
  while true do
    puts string_message
    user_input = gets.chomp
    puts "You entered '#{user_input}'. If you are happy with this value then type yes, otherwise type no"
    user_happy = gets.chomp
    break if user_happy.downcase == "yes"
  end
  user_input.empty? ? default_value : user_input
end

def input_students
  students = []
  name = get_input("Please enter the name of the student", "N/A")
  # while the name is not empty, repeat this code
  while name != "N/A" do
    # get the first student
    cohort = get_input("Please enter the cohort of the student", "January")
    hobbies = get_input("Please enter the hobbies of the student", "None")
    hair = get_input("Please enter the hair colour of the student", "Bald")
    students << {name: name, cohort: cohort.to_sym, hobbies: hobbies, hair: hair}
    puts "Now we have #{students.count} students"
    name = get_input("To finish, just hit return twice, or enter another name to carry on adding students", "N/A")
  end
  # return the array of input_students
  students
end

students = input_students
print_header
print(students)
print_footer(students)
