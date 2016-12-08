# determine terminal width
def get_terminal_width
    h, w = `stty size`.split.map{|e| e.to_i}
    w
end

def get_cohorts
    cohorts = %w(January February March April May June July August September October November December)
    cohorts
end

def interactive_menu
    w = get_terminal_width
    students = []
	loop do
        puts "1. Input the students".center(w)
        puts "2. Show the students".center(w)
        puts "9. Exit".center(w) # 9 because we'll be adding more items
        selection = gets.chomp
        
        case selection
            when "1"
                students = input_students
            when "2"
                print_header
                print_students(students)
                print_students_by_cohort(students)
                print_footer(students)
            when "9"
                exit
            else
                puts "I don't know what you meant, try again"
        end
        
    end

end

def input_students
    w = get_terminal_width
    cohorts = get_cohorts
    puts "\n"
    puts "Please enter the details of the students".center(w)
    puts "To finish, type 'Q' at any time and hit return".center(w)
    puts "\n"

    students = []
    decision = ""
    question = "Please enter the student's"

    while decision != "q" do

        puts "#{question} name".center(w)
        name = gets.delete("\r\n").capitalize
        while name.empty? do
            puts "Error: No name entered".center(w)
            puts "Please enter the student's name".center(w)
            name = gets.delete("\r\n").capitalize
        end
        break if name == "Q"

        puts "#{question} cohort".center(w)
        cohort = gets.delete("\r\n").capitalize.to_sym
        while !cohorts.include? cohort.capitalize.to_s do
            puts "Please enter one of the following cohorts: #{cohorts.join(', ')}".center(w)
            cohort = gets.delete("\r\n").capitalize.to_sym
        end
        break if cohort == :Q

        puts "#{question} age".center(w)
        age = gets.delete("\r\n").capitalize
        age = "Missing" if age == ""
        break if age == "Q"

        puts "#{question} height".center(w)
        height = gets.delete("\r\n").capitalize
        height = "Missing" if height == ""
        break if height == "Q"

        puts "#{question} birthplace".center(w)
        birthplace = gets.delete("\r\n").capitalize
        birthplace = "Missing" if birthplace == ""
        break if birthplace == "Q"

        puts "#{question} hobbies".center(w)
        hobbies = gets.delete("\r\n").capitalize
        hobbies = "Missing" if hobbies == ""
        break if hobbies == "Q"

        students << {name: name, cohort: cohort, age: age, height: height, birthplace: birthplace, hobbies: hobbies}
        puts students.count == 1 ? "Now we have #{students.count} student".center(w) : "Now we have #{students.count} students".center(w)
        puts "\n"
        puts "Hit return to enter another student, or type 'Q' to quit.".center(w)
        decision = gets.delete("\r\n").downcase

    end
    # return the array of students
    return students

end

def print_header
    w = get_terminal_width
    puts "\n\n"
    header = "The Students of Villains Academy"
    puts header.center(w)
    puts ("-" * header.length).center(w)
end

def print_students(students)
    w = get_terminal_width
    if students.size != 0
        index = 0
        puts "\n"
        while index < students.size
            puts "#{index + 1}. #{students[index][:name]} (#{students[index][:cohort]} cohort) - Age: #{students[index][:age]}, Height: #{students[index][:height]}, Birthplace: #{students[index][:birthplace]}, Hobbies: #{students[index][:hobbies]}".center(w)
            index += 1
        end
        puts "\n"
        puts "--------------------------".center(w)
        puts "\n"
    else
        puts "There are no students. I'm lonely :(".center(w)
    end
end

def print_students_by_cohort(students)
    w = get_terminal_width
    if students.size != 0
        cohorts = get_cohorts
        cohorts.each do |x|
            puts "#{x} cohort:".center(w)
            puts "\n"
            students.map do |i|
                if i[:cohort] == x.to_sym
                    puts "#{i[:name]} - Age: #{i[:age]}, Height: #{i[:height]}, Birthplace: #{i[:birthplace]}, Hobbies: #{i[:hobbies]}".center(w)
                end
            end
            puts "\n"
            puts "-------------".center(w)
            puts "\n"
        end
    end
end

def print_footer(names)
    w = get_terminal_width
    if names.size != 0
        puts "\n"
        puts names.count == 1 ? "Overall, we have #{names.count} great student".center(w) : "Overall, we have #{names.count} great students".center(w)
        puts "\n"
    end
end

interactive_menu 

