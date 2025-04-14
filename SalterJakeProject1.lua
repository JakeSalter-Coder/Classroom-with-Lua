--[[ Jake Salter
  [[ Project 1
  [[ Description: This Lua project offers an object oriented solution to manage students in a class
  [[              roster and their grades. This was accomplished with the information provided 
  [[              by the official Programming in Lua documentation: https://www.lua.org/pil/contents.html ]]

--[[ Define Student object to mimic a student class. The NewStudent function acts as a constructor
  [[ This class stucture utilizes closure, which allows private data but does not allow inheritance
  [[ This is outlined in chapter 16.4 of the official Programming in Lua documentation. ]]
local function NewStudent(init_id, init_cla, init_ola, init_quiz, init_test, init_final)
    local self = {
        id = init_id or "",
        cla = tonumber(init_cla) or 0,
        ola = tonumber(init_ola) or 0,
        quiz = tonumber(init_quiz) or 0,
        test = tonumber(init_test) or 0,
        final = tonumber(init_final) or 0,
        letter_grade = ''
    }

    -- Method to get the letter grade.
    local update_letter_grade = function()
        self.total = self.cla + self.ola + self.quiz + self.test + self.final

        if self.total >= 90 then 
            self.letter_grade = 'A'
        elseif self.total >= 87 then
            self.letter_grade = 'B+'
        elseif self.total >= 83 then
            self.letter_grade = 'B'
        elseif self.total >= 80 then
            self.letter_grade = 'B-'
        elseif self.total >= 77 then
            self.letter_grade = 'C+'
        elseif self.total >= 73 then
            self.letter_grade = 'C'
        elseif self.total >= 70 then
            self.letter_grade = 'C-'
        elseif self.total >= 67 then
            self.letter_grade = 'D+'
        elseif self.total >= 63 then
            self.letter_grade = 'D'
        elseif self.total >= 60 then
            self.letter_grade = 'D-'
        else 
            self.letter_grade = 'F'
        end
    end

    -- Get id
    local get_id = function()
        return self.id
    end

    -- Set id
    local set_id = function(new_id)
        self.id = new_id
    end

    -- Get CLA
    local get_cla = function()
        return self.cla
    end

    -- Set CLA
    local set_cla = function (new_cla)
        self.cla = new_cla
        update_letter_grade()
    end

    -- Get OLA
    local get_ola = function()
        return self.ola
    end

    -- Set OLA
    local set_ola = function(new_ola)
        self.ola = new_ola
        update_letter_grade()
    end

    -- Get Quiz
    local get_quiz = function()
        return self.quiz
    end

    -- Set Quiz
    local set_quiz = function(new_quiz)
        self.quiz = new_quiz
        update_letter_grade()
    end

    -- Get Test
    local get_test = function()
        return self.test
    end

    -- Set Test
    local set_test = function(new_test)
        self.test = new_test
        update_letter_grade()
    end

    -- Get Final
    local get_final = function()
        return self.final
    end

    -- Set Final
    local set_final = function(new_final)
        self.final = new_final
        update_letter_grade()
    end

    -- Get Total
    local get_total = function()
        return self.total
    end
    
    -- Set Total
    local set_total = function(new_total)
        self.total = new_total
        update_letter_grade()
    end

    -- Get Letter Grade
    local get_letter_grade = function()
        return self.letter_grade
    end

    -- Set Letter Grade
    local set_letter_grade = function(new_letter_grade)
        self.letter_grade = new_letter_grade
        update_letter_grade()
    end

    -- Update the letter grade before returning
    update_letter_grade()
    return {
        update_letter_grade = update_letter_grade,
        get_id = get_id,
        set_id = set_id,
        get_cla = get_cla,
        set_cla = set_cla,
        get_ola = get_ola,
        set_ola = set_ola,
        get_quiz = get_quiz,
        set_quiz = set_quiz,
        get_test = get_test,
        set_test = set_test,
        get_final = get_final,
        set_final = set_final,
        get_total = get_total,
        set_total = set_total,
        get_letter_grade = get_letter_grade,
        set_letter_grade = set_letter_grade
    }
end


-- Define roster class to hold student information
local function NewRoster(students)
    local self = {
        students_array = students or {}
    }

    -- Private function to retrieve average grades in the roster
    local get_average_grades = function()
        local avg_cla, avg_ola, avg_quiz, avg_test, avg_final, count = 0, 0, 0, 0, 0, 0
        for k, v in pairs(self.students_array) do
            avg_cla = avg_cla + v.get_cla()
            avg_ola = avg_ola + v.get_ola()
            avg_quiz = avg_quiz + v.get_quiz()
            avg_test = avg_test + v.get_test()
            avg_final = avg_final + v.get_final()
            count = count + 1
        end

        return {
            avg_cla = avg_cla/count,
            avg_ola = avg_ola/count,
            avg_quiz = avg_quiz/count,
            avg_test = avg_test/count,
            avg_final = avg_final/count
        }
    end

    -- Private function to find the highest grades in the roster
    local get_highest_grades = function()
        local all_cla, all_ola, all_quiz, all_test, all_final = {}, {}, {}, {}, {}
        for k, v in pairs(self.students_array) do
            all_cla[#all_cla+1] = v.get_cla()
            all_ola[#all_ola+1] = v.get_ola()
            all_quiz[#all_quiz+1] = v.get_quiz()
            all_test[#all_test+1] = v.get_test()
            all_final[#all_final+1] = v.get_final()
        end

        return {
            highest_cla = math.max(table.unpack(all_cla)),
            highest_ola = math.max(table.unpack(all_ola)),
            highest_quiz = math.max(table.unpack(all_quiz)),
            highest_test = math.max(table.unpack(all_test)),
            highest_final = math.max(table.unpack(all_final))
        }
    end

    -- Method to determine if a student with a provided id is in the roster
    local has_student = function(id)
        return self.students_array[id] ~= nil
    end

    -- Print a specific student with the provided id
    local print_student = function(id)
        if has_student then
            local target_student = self.students_array[id]
            print(string.format("\nINFORMATION FOR STUDENT %s", id))
            print("----------------------------------")
            print("CLA: " .. target_student.get_cla())
            print("OLA: " .. target_student.get_ola())
            print("Quiz: " .. target_student.get_quiz())
            print("Test: " .. target_student.get_test())
            print("Final: " .. target_student.get_final())
            print("Total: " .. target_student.get_total())
            print("Letter Grade: " .. target_student.get_letter_grade())
            print("----------------------------------")
        else 
            print("No student with id: " .. id .. " found.") 
        end
    end

    -- Prints all the information of the roster
    local print_roster = function()
        print(string.format("\n%56s", "TOTAL ROSTER INFORMATION"))
        print("--------------------------------------------------------------------------------------------")
        for k, v in pairs(self.students_array) do
            print(string.format("ID: %s CLA: %2d OLA: %2d Quiz: %2d Test: %2d Final: %2d Total: %3d Letter Grade: %-2s",
                                v.get_id(), v.get_cla(), v.get_ola(), v.get_quiz(),
                                v.get_test(), v.get_final(), v.get_total(), v.get_letter_grade()))
        end

        local avg_grades = get_average_grades()
        local highest_grades = get_highest_grades()
        print(string.format("\nAverage CLA: %.1f", avg_grades.avg_cla))
        print("Highest CLA: " .. highest_grades.highest_cla)
        print(string.format("\nAverage OLA: %.1f", avg_grades.avg_ola))
        print("Highest OLA: " .. highest_grades.highest_ola)
        print(string.format("\nAverage Quiz: %.1f", avg_grades.avg_quiz))
        print("Highest Quiz: " .. highest_grades.highest_quiz)
        print(string.format("\nAverage Test: %.1f", avg_grades.avg_test))
        print("Highest Test: " .. highest_grades.highest_test)
        print(string.format("\nAverage Final: %.1f", avg_grades.avg_final))
        print("Highest Final: " .. highest_grades.highest_final)
        print("--------------------------------------------------------------------------------------------")
    end

    -- Get student object with provided id
    local get_student = function(id)
        if has_student(id) then
            return self.students_array[id]
        else
            print("No student with id: " .. id .. " found.") 
        end
    end

    -- Add student to the roster with a student object
    local add_student = function(student)
        if has_student(student:get_id()) then
            print("Student with id: " .. student.get_id() .. " is already in the roster.")
        else
            self.students_array[student.get_id()] = student
        end
    end

    -- Add student with grade information
    local create_student = function(id, cla, ola, quiz, test, final)
        if has_student(id) then
            print("Student with id: " .. id .. " is already in the roster.")
        else
            self.students_array[id] = NewStudent(id, cla, ola, quiz, test, final)
        end
    end

    -- Update student with a new student object
    local update_student = function(student)
        if has_student(student.get_id()) then
            self.students_array[student.get_id()] = student
        else 
            print("Student with id: " .. student.get_id() .. " is not in the roster.")
        end
    end

    -- Update the ID of the student with the provided id
    local update_student_id = function(cur_id, final_id)
        if has_student(cur_id) then
            self.students_array[final_id] = self.students_array[cur_id].set_id(final_id)
            table.remove(self.students_array, cur_id)
        else
            print("Student with id: " .. cur_id .. " is not in the roster.")
        end
    end

    -- Update the CLA grade of the student with the provided id
    local update_student_cla = function(id, new_cla)
        if has_student(id) then
            self.students_array[id].set_cla(new_cla)
        else
            print("Student with id: " .. id .. " is not in the roster.")
        end
    end

    -- Update the OLA grade of the student with the provided id
    local update_student_ola = function(id, new_ola)
        if has_student(id) then
            self.students_array[id].set_ola(new_ola)
        else
            print("Student with id: " .. id .. " is not in the roster.")
        end
    end

    -- Update the Quiz grade of the student with the provided id
    local update_student_quiz = function(id, new_quiz)
        if has_student(id) then
            self.students_array[id].set_quiz(new_quiz)
        else
            print("Student with id: " .. id .. " is not in the roster.")
        end
    end

    -- Update the Test grade of the student with the provided id
    local update_student_test = function(id, new_test)
        if has_student(id) then
            self.students_array[id].set_test(new_test)
        else
            print("Student with id: " .. id .. " is not in the roster.")
        end
    end

    -- Update the Final grade of the student with the provided id
    local update_student_final = function(id, new_final)
        if has_student(id) then
            self.students_array[id].set_final(new_final)
        else
            print("Student with id: " .. id .. " is not in the roster.")
        end
    end

    return {
        has_student = has_student,
        print_student = print_student,
        print_roster = print_roster,
        get_student = get_student,
        add_student = add_student,
        create_student = create_student,
        update_student = update_student,
        update_student_id = update_student_id,
        update_student_cla = update_student_cla,
        update_student_ola = update_student_ola,
        update_student_quiz = update_student_quiz,
        update_student_test = update_student_test,
        update_student_final = update_student_final,
    }
end

--[[ Function to read in the student information from the given file. 
  [[ This function is written with guidance from chapter 21.1 of the official Programming in Lua documentation]]
local function ReadFile(file_name)
    local file = io.open(file_name, 'r')
    if file == nil then
        print("Unable to open the file: " .. file_name)
        return
    else
        io.input(file)
    end

    local line = io.read() -- clear the header
    local roster = NewRoster()
    while true do
        line = io.read()
        if line == nil then break end
        local temp_info = {}
        for v in string.gmatch(line, "[a-zA-Z0-9]+") do
            temp_info[#temp_info+1] = v
        end
        roster.create_student(temp_info[1], temp_info[2], temp_info[3], temp_info[4], temp_info[5], temp_info[6])
    end
    return roster
end

-- Main function
function Main()
    io.write("Enter a file name: ")
    local file_name = io.read()

    local roster = ReadFile(file_name)
    if roster == nil then return end

    roster.print_student("c1234501")
    roster.print_student("c1234514")

    roster.print_roster()
end


Main()