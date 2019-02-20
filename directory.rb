@students = [] # an empty array accessible to all methods
# First thing's first, lets pop these students into a cheeky array

def print_header
  puts "The students of Villains Academy".center(100)
  puts "--------------------------------".center(100)
end

def print_students_list(cohort)
  print_header
  @students = @students.select {|student| student[:name][0] == "A" && student[:name].length < 12 && student[:cohort] == cohort.to_sym}
  @students.each_with_index do |student, i|
    puts "#{i + 1} #{student[:name]} (#{student[:cohort]} cohort). Hobbies are #{student[:hobbies]} and student has #{student[:hair]} hair".center(100)
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great student#{@students.count > 1 ? "s" :""}".center(100)
end

def get_input(string_message, default_value)
  user_input = ""
  while true do
    #Display string asking for input
    puts string_message
    #Get user input
    user_input = STDIN.gets.delete_suffix("\n")
    puts "You entered '#{user_input}'. If you are happy with this value then hit enter, otherwise type no"
    user_happy = STDIN.gets.delete_suffix("\n")
    #Break loop if user is happy with input, otherwise start loop again
    break if user_happy.empty?
  end
  #Returns default value if the user input is empty
  user_input.empty? ? default_value : user_input
end

def load_students(filename = "students.csv")
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  name, cohort, hobbies, hair = line.chomp.split(',')
  add_students(name, cohort, hobbies, hair)
  end
  file.close
end

def add_students(name, cohort, hobbies, hair)
  @students << {name: name, cohort: cohort.to_sym, hobbies: hobbies, hair: hair}
end

def input_students
  name = get_input("Please enter the name of the student", "N/A")
  # while the name is not empty, repeat this code
  while name != "N/A" do
    # get the first student
    cohort = get_input("Please enter the cohort of the student", "January")
    hobbies = get_input("Please enter the hobbies of the student", "non existent")
    hair = get_input("Please enter the hair colour of the student", "no")
    add_students(name, cohort, hobbies, hair)
    puts "Now we have #{@students.count} students"
    name = get_input("To finish, just hit return twice, or enter another name to carry on adding students", "N/A")
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Loads the list of students from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  print_students_list(get_input("Choose a cohort to view", "January"))
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
       save_students
    when "4"
       load_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def interactive_menu
  try_load_students
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort],student[:hobbies], student[:hair]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

interactive_menu
