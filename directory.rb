require 'csv'

@students = [] # an empty array accessible to all methods
# First thing's first, lets pop these students into a cheeky array

def print_header(cohort)
  puts "The students of Villains Academy - #{cohort} Cohort#{cohort.empty? ? "s" : ""}".center(100)
  puts "--------------------------------".center(100)
end

def print_cohort_list(cohort)
  print_header(cohort)
  if !cohort.empty?
    @students.select {|student| student[:cohort] == cohort.to_sym}.each_with_index do |student, i|
      puts "#{i + 1} #{student[:name]} (#{student[:cohort]} cohort). Hobbies are #{student[:hobbies]} and student has #{student[:hair]} hair".center(100)
    end
  else
    @students.each_with_index do |student, i|
      puts "#{i + 1} #{student[:name]} (#{student[:cohort]} cohort). Hobbies are #{student[:hobbies]} and student has #{student[:hair]} hair".center(100)
    end
  end
end

def print_footer(cohort)
  count_students_in_cohort = @students.select {|student| student[:cohort] == cohort.to_sym}.length
  count_students = @students.count
  puts "In this cohort we have #{count_students_in_cohort} great student#{count_students_in_cohort > 1 ? "s" :""}".center(100) if cohort.downcase != "all"
  puts "Overall, we have #{count_students} great student#{count_students > 1 ? "s" :""}".center(100)
end

def get_input(string_message, default_value = "")
  user_input = ""
  while true do
    #Display string asking for input
    puts string_message
    #Get user input
    user_input = STDIN.gets.chomp
    puts "You entered '#{user_input}'. If you are happy with this value then hit enter, otherwise type no"
    user_happy = STDIN.gets.chomp
    #Break loop if user is happy with input, otherwise start loop again
    break if user_happy.empty?
  end
  #Returns default value if the user input is empty
  user_input.empty? ? default_value : user_input
end

def add_student(name, cohort, hobbies, hair)
  @students << {name: name, cohort: cohort.to_sym, hobbies: hobbies, hair: hair}
end

def input_students
  name = get_input("Please enter the name of the student", "N/A")
  # while the name is not N/A, repeat this code
  while name != "N/A" do
    cohort = get_input("Please enter the cohort of the student", "January")
    hobbies = get_input("Please enter the hobbies of the student", "non existent")
    hair = get_input("Please enter the hair colour of the student", "no")
    add_student(name, cohort, hobbies, hair)
    puts "Now we have #{@students.count} students"
    name = get_input("To finish, just hit return twice, or enter another name to carry on adding students", "N/A")
  end
  print_status_message("New students have been Succesfully enrolled")
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list of students to a csv file"
  puts "4. Load a list of students from a csv file"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students_in_cohort
  cohort = get_input("Choose a cohort to view. To see all cohorts just hit return twice", "")
  print_cohort_list(cohort)
  print_footer(cohort)
end

def process_menu_interaction(selection)
    return input_students if selection == "1"
    return show_students_in_cohort if selection == "2"
    return save_students(get_input("Type in a filename to save to")) if selection == "3"
    return load_students_csv(get_input("Type in a filename to load from")) if selection == "4"
    return exit if selection == "9"
    puts "I don't know what you mean, try again"
end

def interactive_menu
  try_load_students_csv
  loop do
    print_menu
    process_menu_interaction(STDIN.gets.chomp)
  end
end

def save_students(filename)
    CSV.open(filename, "w") do |csv|
      @students.each do |student|
        csv << [student[:name], student[:cohort],student[:hobbies], student[:hair]]
      end
    end
  print_status_message("Succesfully saved to #{filename}")
end

def print_status_message(message)
  puts "\n#{"-" * (message.length + 20)}\n"
  puts (message).center(message.length + 20)
  puts "#{"-" * (message.length + 20)}\n\n"
end

def load_students_csv(filename = "students.csv")
  if File.exists?(filename) # if it exists
    CSV.foreach(filename) do |row|
      name, cohort, hobbies, hair = row
      add_student(name, cohort, hobbies, hair)
    end
    print_status_message("Succesfully loaded students from #{filename}")
  else
    print_status_message("File #{filename} not found. Please input some students (Option 1) and save them (Option 3) before attempting to load from a file")
  end
end

def try_load_students_csv
  filename = ARGV.first # first argument from the command line
  return load_students_csv if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students_csv(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

interactive_menu
