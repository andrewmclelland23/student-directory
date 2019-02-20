# First thing's first, lets pop these students into a cheeky array
students = [
  {name: "Andy", cohort: :January, hobbies: "Tennis", hair: "brown"},
  {name: "Andrew", cohort: :January, hobbies: "Football", hair: "bald"},
  {name: "Angela", cohort: :February, hobbies: "Tennis", hair: "red"}
]
def print_header
  puts "The students of Villains Academy".center(100)
  puts "--------------------------------".center(100)
end

def print(student_list, cohort)
  print_header
  students = student_list.select {|student| student[:name][0] == "A" && student[:name].length < 12 && student[:cohort] == cohort.to_sym}
  students.each_with_index do |student, i|
    puts "#{i + 1} #{student[:name]} (#{student[:cohort]} cohort). Hobbies are #{student[:hobbies]} and student has #{student[:hair]} hair".center(100)
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(100)
end

def get_input(string_message, default_value)
  user_input = ""
  while true do
    #Display string asking for input
    puts string_message
    #Get user input
    user_input = gets.chomp
    puts "You entered '#{user_input}'. If you are happy with this value then hit enter, otherwise type no"
    user_happy = gets.chomp
    #Break loop if user is happy with input, otherwise start loop again
    break if user_happy.empty?
  end
  #Returns default value if the user input is empty
  user_input.empty? ? default_value : user_input
end

def input_students
  students = []
  name = get_input("Please enter the name of the student", "N/A")
  # while the name is not empty, repeat this code
  while name != "N/A" do
    # get the first student
    cohort = get_input("Please enter the cohort of the student", "January")
    hobbies = get_input("Please enter the hobbies of the student", "non existent")
    hair = get_input("Please enter the hair colour of the student", "no")
    students << {name: name, cohort: cohort.to_sym, hobbies: hobbies, hair: hair}
    puts "Now we have #{students.count} students"
    name = get_input("To finish, just hit return twice, or enter another name to carry on adding students", "N/A")
  end
  # return the array of input_students
  students
end

students = input_students
print(students, get_input("Choose a cohort to view", "January"))
print_footer(students)
