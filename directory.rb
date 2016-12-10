require 'csv'

@students = [] 

# determine terminal width
@h, @w = `stty size`.split.map{|e| e.to_i}

@cohorts = %w(January February March April May June July August September October November December)

def try_load_students
    filename = ARGV.first
    if filename.nil?
        load_students
    elsif
        File.exists?(filename)
        load_students(filename)
    else
        puts "Sorry, #{filename} does not exist.".center(@w)
        exit
    end
end

def load_students(filename = "students.csv")
    if File.exists?(filename)
        keys = [:name, :cohort, :age, :height, :birthplace, :hobbies]
        values = CSV.parse(File.read(filename))
        values.each do |value|
            @students << Hash[keys.zip(value)]
            @students.select { |i| i[:cohort] = i[:cohort].to_sym }
        end
        puts "\n"
        puts "Loaded #{@students.count} students from #{filename}".center(@w)
        puts "\n"
        puts "--------------------------".center(@w)
        puts "\n"
    else
        puts "Sorry, #{filename} does not exist.".center(@w)
    end
end

def save_students(filename = "students.csv")
    CSV.open(filename, "w") do |csv_object|
        student_data = []
        @students.each do |student|
            student_data = student[:name], student[:cohort], student[:age], student[:height], student[:birthplace], student[:hobbies]
            csv_object << student_data
        end
    end    
    puts "Students saved to file".center(@w)
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
    puts "\n"
    puts "1. Input the students".center(@w)
    puts "2. Show the students".center(@w)
    puts "3. Save the list to file".center(@w)
    puts "4. Load the list from file".center(@w)
    puts "9. Exit".center(@w)
    puts "\n"
end

def process(selection)
    case selection
        when "1"
            puts "You have selected: \"Input Students\"".center(@w)
            input_students
        when "2"
            puts "Listing students...".center(@w)
            show_students
        when "3"
            puts "You have selected: \"Save Students\"".center(@w)
            puts "Please enter the filename you would like to save to:".center(@w)
            filename = gets.chomp
            filename = "students.csv" if filename == ""
            save_students(filename)
            puts "Saving students...".center(@w)
        when "4"
            puts "You have selected: \"Load Students\"".center(@w)
            puts "Please enter the filename you would like to load from:".center(@w)
            filename = gets.chomp
            filename = "students.csv" if filename == ""
            load_students(filename)
        when "9"
            puts "Exiting application...".center(@w)
            exit
        else
            puts "I don't know what you meant, try again".center(@w)
    end 
end

def input_students
    puts "\n"
    puts "Please enter the details of the students".center(@w)
    puts "To finish, type 'Q' at any time and hit return".center(@w)
    puts "\n"
    new_students = 0
    specifics = %w(name cohort age height birthplace hobbies)
    answer = ""
    while answer != "q" do
        student_details = []
        n = 0
        specifics.each do |attribute|
            puts "Please enter the student's #{attribute}".center(@w)
            answer = STDIN.gets.chomp.capitalize
            break if answer == "Q"
            if n == 0
                while answer == "" do
                    puts "Error: No #{attribute} entered".center(@w)
                    puts "Please enter the student's #{attribute}".center(@w)
                    answer = STDIN.gets.chomp.capitalize
                end
            elsif n == 1
                while !@cohorts.include? answer.capitalize.to_s do
                    puts "Error! Please input one of the following cohorts: #{@cohorts.join(', ')}".center(@w)
                    answer = STDIN.gets.chomp.capitalize
                end
            else
                answer = "Missing"
            end
            student_details << answer
            n += 1
        end
        break if answer == "Q"
        new_students = add_student_details(*student_details, new_students)
        puts @students.count == 1 ? "Now we have #{@students.count} student".center(@w) : "Now we have #{@students.count} students".center(@w)
        puts "\n"
        puts "Hit return to enter another student, or type 'Q' to go back to the previous menu.".center(@w)
        answer = STDIN.gets.chomp.downcase
    end
    puts new_students == 1 ? "#{new_students} student added successfully".center(@w) : "#{new_students} students added successfully".center(@w)
end

def add_student_details(name, cohort, age, height, birthplace, hobbies, new_students)
    @students << {name: name, cohort: cohort.to_sym, age: age, height: height, birthplace: birthplace, hobbies: hobbies}
    return new_students += 1
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

try_load_students
interactive_menu