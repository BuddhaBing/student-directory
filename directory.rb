def input_students
    # get height and width of terminal window for center
    h, w = `stty size`.split.map{|e| e.to_i}
    puts "\n"
    puts "Please enter the details of the students".center(w)
    puts "To finish, just hit return twice".center(w)
    puts "\n"
    # create an empty array
    students = []
    question = "Please enter the student's"
    1.times do
        puts "#{question} name".center(w)
        name = gets.chomp
        break if name.empty?
        puts "#{question} age".center(w)
        age = gets.chomp
        break if age.empty?
        puts "#{question} height".center(w)
        height = gets.chomp
        break if height.empty?
        puts "#{question} birthplace".center(w)
        birthplace = gets.chomp
        break if birthplace.empty?
        puts "#{question} hobbies".center(w)
        hobbies = gets.chomp
        break if hobbies.empty?
        while !name.empty? do
            # add the student hash to the array
            students << {name: name, cohort: :november, age: age, height: height, birthplace: birthplace, hobbies: hobbies}
            puts "Now we have #{students.count} students\n\n".center(w)
            # get another name from the user
            puts "#{question} name".center(w)
            name = gets.chomp
            break if name.empty?
            puts "#{question} age".center(w)
            age = gets.chomp
            break if age.empty?
            puts "#{question} height".center(w)
            height = gets.chomp
            break if height.empty?
            puts "#{question} birthplace".center(w)
            birthplace = gets.chomp
            break if birthplace.empty?
            puts "#{question} hobbies".center(w)
            hobbies = gets.chomp
            break if hobbies.empty?
        end
    end
    # return the array of students
    students
end

def print_header
    puts "The students of Villains Academy"
    puts "-------------"
end

def print(students)
    index = 0
    while index < students.size
        puts "#{index + 1}. #{students[index][:name]} (#{students[index][:cohort].capitalize} cohort) - Age: #{students[index][:age]}, Height: #{students[index][:height]}, Birthplace: #{students[index][:birthplace]}, Hobbies: #{students[index][:hobbies]}"
        index += 1
    end
end

def print_footer(names)
    puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)