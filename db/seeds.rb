# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts Survey.create(title: "미니멀스킨", code: "0", total: 0).title
puts Survey.create(title: "라인업", code: "1", total: 0).title
puts Survey.create(title: "시티파이", code: "2", total: 0).title
puts Survey.create(title: "어프라이즈", code: "3", total: 0).title