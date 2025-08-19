# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all

User.create({
  username: "nol0428",
  email: "naing@mail.com",
  password: "123456",
  age: 27,
  gender: "Male",
  music_style: "Pop",
  musician_type: "Semi-Pro"
})

User.create({
  username:  "paul",
  email: "paul@email.com",
  password: "password",
  age: 42,
  gender: "Male",
  music_style: "R&B",
  musician_type: "Virtuoso"
})

User.create({
  username: "gooner",
  email: "gonner@gmail.com",
  password:"gooner1234",
  age: 41,
  gender: "male",
  music_style: "Hip-Hop",
  musician_type: "Hobbyist"
})

User.create({
  username:  "vince",
  email: "vince@email.com",
  password: "123456",
  age: 30,
  gender: "Male",
  music_style: "Country",
  musician_type: "Beginner"
})

User.all.each do |user|
  5.times do
    Song.create({
    user: user,
    title: "Title",
    generated_lyrics: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Unde fugit sit delectus. Ab error pariatur illo fugit eaque ut, voluptate rerum animi nulla doloremque suscipit magni iste distinctio, architecto repudiandae."
    })
  end
end
