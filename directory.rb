# First thing's first, lets pop these students into a cheeky array
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]
# Now we'll print them
puts "The students of Villains Academy"
puts "---------------------------------"
students.each {|student| puts student}
# Then we print the total number of students
puts "Overall, we have #{students.count} great students"
