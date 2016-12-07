# determine terminal width
def get_terminal_width
    h, w = `stty size`.split.map{|e| e.to_i}
    w
end

def get_cohorts
    cohorts = %w(January February March April May June July August September October November December)
    cohorts
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
        name = gets.chomp.capitalize
        while name.empty? do
            puts "Error: No name entered".center(w)
            puts "Please enter the student's name".center(w)
            name = gets.chomp.capitalize
        end
        break if name == "Q"
        
        puts "#{question} cohort".center(w)
        cohort = gets.chomp.capitalize.to_sym
        while !cohorts.include? cohort.capitalize.to_s do
            puts "Please enter one of the following cohorts: #{cohorts.join(', ')}".center(w)
            cohort = gets.chomp.capitalize.to_sym
        end
        break if cohort == :Q
        
        puts "#{question} age".center(w)
        age = gets.chomp.capitalize
        age = "Missing" if age == ""
        break if age == "Q"
        
        puts "#{question} height".center(w)
        height = gets.chomp.capitalize
        height = "Missing" if height == ""
        break if height == "Q"
        
        puts "#{question} birthplace".center(w)
        birthplace = gets.chomp.capitalize
        birthplace = "Missing" if birthplace == ""
        break if birthplace == "Q"
        
        puts "#{question} hobbies".center(w)
        hobbies = gets.chomp.capitalize
        hobbies = "Missing" if hobbies == ""
        break if hobbies == "Q"
        
        students << {name: name, cohort: cohort, age: age, height: height, birthplace: birthplace, hobbies: hobbies}
        #students.merge(default_vals)
        puts "Now we have #{students.count} students\n\n".center(w)
        
        puts "Hit return to enter another student, or type 'Q' to quit.".center(w)
        decision = gets.chomp.downcase
        
    end
    # return the array of students
    return students
    
end

def print_students_by_cohort(students)
    w = get_terminal_width
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

def print_header
    w = get_terminal_width
    puts "The students of Villains Academy".center(w)
    puts "-------------".center(w)
end

def print(students)
    w = get_terminal_width
    index = 0
    while index < students.size
        puts "#{index + 1}. #{students[index][:name]} (#{students[index][:cohort]} cohort) - Age: #{students[index][:age]}, Height: #{students[index][:height]}, Birthplace: #{students[index][:birthplace]}, Hobbies: #{students[index][:hobbies]}".center(w)
        index += 1
    end
end

def print_footer(names)
    w = get_terminal_width
    puts "\n"
    puts "Overall, we have #{names.count} great students".center(w)
    puts "\n"
end

students = input_students
print_header
print(students)
print_students_by_cohort(students)
print_footer(students)