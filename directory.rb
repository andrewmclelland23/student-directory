# First thing's first, lets pop these students into a cheeky array
students = [
  {name: "Andy", cohort: :January, hobbies: "Tennis", hair: "brown"},
  {name: "Andrew", cohort: :January, hobbies: "Football", hair: "no"},
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
  puts "Overall, we have #{students.count} great student#{students.count > 1 ? "s" :""}".center(100)
end

def get_input(string_message, default_value)
  user_input = ""
  while true do
    #Display string asking for input
    puts string_message
    #Get user input
    user_input = gets.delete_suffix("\n")
    puts "You entered '#{user_input}'. If you are happy with this value then hit enter, otherwise type no"
    user_happy = gets.delete_suffix("\n")
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

def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      print(students, get_input("Choose a cohort to view", "January"))
      print_footer(students)
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end

interactive_menu
