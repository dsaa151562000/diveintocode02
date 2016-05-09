# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# (1..100).each do |i|
# name = Faker::Name.name
# 100.times do |i|
# i += 1
# #(1..10).each do |i|
# name = Faker::Japanese::Name.name
# email = "example#{i}@railstutorial.org"
# password = "password"
# provider = "provider#{i}"
# User.create!(name: name,
# email: email,
# password: password,
# provider: provider
# )
# end

1000.times do |n|
  n += 1
  name  = Faker::Japanese::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  provider = "provider#{n+1}"
  User.create!(name:  name,
              email: email,
              password:  password,
              provider: provider
              )
end

1000.times do |n|
n += 1
title = "ダミータイトル#{n+1}"
content = "ダミー内容-#{n+1}"
Blog.create!(title: title,content: content,user_id: n)
end