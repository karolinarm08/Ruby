require 'date'

class Student
  attr_accessor :surname, :name, :date_of_birth

  @@students = []

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = Date.parse(date_of_birth)

    raise ArgumentError, 'Date of birth must be in the past' if @date_of_birth >= Date.today

    add_student
  end

  def calculate_age
    now = Date.today
    age = now.year - @date_of_birth.year
    age -= 1 if (now.month < @date_of_birth.month) || (now.month == @date_of_birth.month && now.day < @date_of_birth.day)
    age
  end

  def add_student
    if @@students.none? { |student| student.name == @name && student.surname == @surname && student.date_of_birth == @date_of_birth }
      @@students << self
    end
  end

  def remove_student
    @@students.delete_if { |student| student == self }
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end

  def self.all_students
    @@students
  end
end

begin
  student1 = Student.new("Williams", "James", "2004-08-07")
  student2 = Student.new("Anderson", "Amelia", "2006-05-26")
  student3 = Student.new("Harris", "Ethan", "2006-08-07")
  student4 = Student.new("Young", "Liam", "2025-08-07")
rescue ArgumentError => e
  puts e.message
end

puts "All students:"
Student.all_students.each do |student|
  puts "#{student.surname} #{student.name} #{student.date_of_birth}"
end

puts "\nStudent age #{student2.name} #{student2.surname}: #{student2.calculate_age} years old"

age = 18
puts "\nStudents aged #{age} years old:"
students_by_age = Student.get_students_by_age(age)
students_by_age.each do |student|
  puts "#{student.surname} #{student.name} #{student.date_of_birth}"
end

name = "Amelia"
puts "\nStudents named #{name}:"
students_by_name = Student.get_students_by_name(name)
students_by_name.each do |student|
  puts "#{student.surname} #{student.name} #{student.date_of_birth}"
end

puts "\nRemove student1"
student1.remove_student

puts "\nList of student after removal:"
Student.all_students.each do |student|
  puts "#{student.surname} #{student.name} #{student.date_of_birth}"
end
