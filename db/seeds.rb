# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do |n|
  name = Faker::HarryPotter.character
  email = Faker::Internet.email
  password = Faker::Internet.password
  user = User.create(
    name: name,
    email: email,
    password: password,
  )

  topic = Topic.new(
    content: 'トピック',
  user_id: user.id)

  100.times do
    topic.comments.build(
      content: 'コメント',
    user_id: user.id)
  end

  topic.save

end
