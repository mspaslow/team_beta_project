require 'ffaker'

  # Create Admin User
  AdminUser.create!(
    email:    "admin@example.com",
    password: "password",
  )

  # Student
  Student.create!(
      nickname: "student",
      password: "password",
      email:    "student@example.com",
      first_name: "Pan",
      last_name:  "Student",
      id_number:  "1293123",
      avatar:     FFaker::Avatar.image
  )

  puts "\nCreating students:"
  50.times do |s|
    Student.create!(
      first_name: FFaker::Name.first_name,
      last_name:  FFaker::Name.last_name,
      nickname:   FFaker::Name.first_name.split("").shuffle.join.downcase << rand(100).to_s,
      email:      FFaker::Internet.email,
      id_number:  "ID000#{s+1}",
      password:   FFaker::Internet.password,
      bio:        FFaker::Lorem.paragraph,
      avatar:     FFaker::Avatar.image
    )
    print '.'
  end

  all_students = Student.all
  number = 0
  while all_students.count > 0
    capacity = [1,2,3,4].sample
    room = Room.create!(
      name: "Room's name",
      number: number += 1,
      capacity: capacity
    )

    roommates = all_students.sample(capacity)
    room.students << roommates

    all_students -= roommates
  end


  puts "\nCreating expenses:"
    100.times do
      master
      students = Student.all
      count = (rand(5) + 1).to_f
      price = (rand()*100).round(2).to_f
      category = %w(alcohol cleaners food entertainment other).sample

      expense = Expense.create!(
        purchaser_id: students.sample.id,
        title: FFaker::Book.title,
        description: FFaker::Book.description,
        category: category,
        date: rand(5).days.ago,
        price: price,
        divided_price: (price/count).round(2)
      )

      students = students.shuffle[0..count]

      students.each do |s|
        ContributorExpense.create!(
          student_id: s.id,
          expense_id: expense.id,
          payed: false
        ) 
      end

      print '.'
    end
