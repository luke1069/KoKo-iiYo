# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  [
    {
      name: 'test1',
      email: 'test1@test.com',
      password: 'luke0630',
      introduction: '宜しくお願い致します。',
    },
    {
      name: 'test2',
      email: 'test2@test.com',
      password: 'luke0630',
      introduction: '宜しくお願い致します。'
    },
    {
      name: 'test3',
      email: 'test3@test.com',
      password: 'luke0630',
      introduction: '宜しくお願い致します。'
    },
    {
      name: 'test4',
      email: 'test4@test.com',
      password: 'luke0630',
      introduction: '宜しくお願い致します。'
    },
    {
      name: 'test5',
      email: 'test5@test.com',
      password: 'luke0630',
      introduction: '宜しくお願い致します。'
    }
    ]
  )
