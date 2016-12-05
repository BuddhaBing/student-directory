def input_students
    puts "Please enter the details of the students"
    puts "To finish, just hit return twice"
    # create an empty array
    students = []
    question = "Please enter the student's"
    1.times do
        puts "#{question} name"
        name = gets.chomp
        break if name.empty?
        puts "#{question} age"
        age = gets.chomp
        break if age.empty?
        puts "#{question} height"
        height = gets.chomp
        break if height.empty?
        puts "#{question} birthplace"
        birthplace = gets.chomp
        break if birthplace.empty?
        puts "#{question} hobbies"
        hobbies = gets.chomp
        break if hobbies.empty?
        while !name.empty? do
            # add the student hash to the array
            students << {name: name, cohort: :november, age: age, height: height, birthplace: birthplace, hobbies: hobbies}
            puts "Now we have #{students.count} students\n\n"
            # get another name from the user
            puts "#{question} name"
            name = gets.chomp
            break if name.empty?
            puts "#{question} age"
            age = gets.chomp
            break if age.empty?
            puts "#{question} height"
            height = gets.chomp
            break if height.empty?
            puts "#{question} birthplace"
            birthplace = gets.chomp
            break if birthplace.empty?
            puts "#{question} hobbies"
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