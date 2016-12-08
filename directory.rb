@students = [] 

# determine terminal width
@h, @w = `stty size`.split.map{|e| e.to_i}

@cohorts = %w(January February March April May June July August September October November December)

def try_load_students
    filename = ARGV.first
    return if filename.nil?
    if File.exists?(filename)
        load_students(filename)
    else
        puts "Sorry, #{filename} does not exist."
        exit
    end
end

def load_students(filename = "students.csv")
    file = File.open(filename, "r") 
    file.readlines.each do |line|
        name, cohort, age, height, birthplace, hobbies = line.chomp.split(",")
        @students << {name: name, cohort: cohort.to_sym, age: age, height: height, birthplace: birthplace, hobbies: hobbies}
    end
    file.close
    puts "\n"
    puts "Loaded #{@students.count} students from #{filename}".center(@w)
    puts "\n"
    puts "--------------------------".center(@w)
    puts "\n"
end

def interactive_menu
	loop do
	    print_menu
        process(STDIN.gets.chomp)
    end
end

def print_menu
    puts "1. Input the students".center(@w)
    puts "2. Show the students".center(@w)
    puts "3. Save the list to students.csv".center(@w)
    puts "4. Load the list from students.csv".center(@w)
    puts "9. Exit".center(@w) # 9 because we'll be adding more items
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
            puts "I don't know what you meant, try again"
    end 
end

def input_students
    puts "\n"
    puts "Please enter the details of the students".center(@w)
    puts "To finish, type 'Q' at any time and hit return".center(@w)
    puts "\n"

    decision = ""
    question = "Please enter the student's"

    while decision != "q" do

        puts "#{question} name".center(@w)
        name = STDIN.gets.delete("\r\n").capitalize
        while name.empty? do
            puts "Error: No name entered".center(@w)
            puts "Please enter the student's name".center(@w)
            name = STDIN.gets.delete("\r\n").capitalize
        end
        break if name == "Q"

        puts "#{question} cohort".center(@w)
        cohort = STDIN.gets.delete("\r\n").capitalize.to_sym
        while !@cohorts.include? cohort.capitalize.to_s do
            puts "Please enter one of the following cohorts: #{@cohorts.join(', ')}".center(@w)
            cohort = STDIN.gets.delete("\r\n").capitalize.to_sym
        end
        break if cohort == :Q

        puts "#{question} age".center(@w)
        age = STDIN.gets.delete("\r\n").capitalize
        age = "Missing" if age == ""
        break if age == "Q"

        puts "#{question} height".center(@w)
        height = STDIN.gets.delete("\r\n").capitalize
        height = "Missing" if height == ""
        break if height == "Q"

        puts "#{question} birthplace".center(@w)
        birthplace = STDIN.gets.delete("\r\n").capitalize
        birthplace = "Missing" if birthplace == ""
        break if birthplace == "Q"

        puts "#{question} hobbies".center(@w)
        hobbies = STDIN.gets.delete("\r\n").capitalize
        hobbies = "Missing" if hobbies == ""
        break if hobbies == "Q"

        @students << {name: name, cohort: cohort, age: age, height: height, birthplace: birthplace, hobbies: hobbies}
        puts @students.count == 1 ? "Now we have #{@students.count} student".center(@w) : "Now we have #{@students.count} students".center(@w)
        puts "\n"
        puts "Hit return to enter another student, or type 'Q' to go back to the previous menu.".center(@w)
        decision = STDIN.gets.delete("\r\n").downcase

    end
    # return the array of students
    return @students

end

def show_students
    print_header
    print_students
    print_students_by_cohort
    print_footer
end

def print_header
    puts "\n\n"
    header = "The Students of Villains Academy"
    puts header.center(@w)
    puts ("-" * header.length).center(@w)
end

def print_students
    if @students.size != 0
        index = 0
        puts "\n"
        while index < @students.size
            puts "#{index + 1}. #{@students[index][:name]} (#{@students[index][:cohort]} cohort) - Age: #{@students[index][:age]}, Height: #{@students[index][:height]}, Birthplace: #{@students[index][:birthplace]}, Hobbies: #{@students[index][:hobbies]}".center(@w)
            index += 1
        end
        puts "\n"
        puts "--------------------------".center(@w)
        puts "\n"
    else
        puts "There are no students. I'm lonely :(".center(@w)
    end
end

def print_students_by_cohort
    if @students.size != 0
        @cohorts.each do |x|
            puts "#{x} cohort:".center(@w)
            puts "\n"
            @students.map do |i|
                if i[:cohort] == x.to_sym
                    puts "#{i[:name]} - Age: #{i[:age]}, Height: #{i[:height]}, Birthplace: #{i[:birthplace]}, Hobbies: #{i[:hobbies]}".center(@w)
                end
            end
            puts "\n"
            puts "-------------".center(@w)
            puts "\n"
        end
    end
end

def print_footer    
    if @students.size != 0
        puts "\n"
        puts @students.count == 1 ? "Overall, we have #{@students.count} great student".center(@w) : "Overall, we have #{@students.count} great students".center(@w)
        puts "\n"
    end
end

def save_students
    file = File.open("students.csv", "w")
    @students.each do |student|
        student_data = [student[:name], student[:cohort], student[:age], student[:height], student[:birthplace], student[:hobbies]]
        csv_line = student_data.join(",")
        file.puts csv_line
    end
    file.close
    puts "Students saved to file".center(@w)
    puts "\n"
    puts "--------------------------".center(@w)
    puts "\n"
end

try_load_students
interactive_menu 

