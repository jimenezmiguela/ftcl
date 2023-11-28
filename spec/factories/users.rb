require 'faker'

FactoryBot.define do

  factory :user do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.category { Faker::Lorem.word }
  end
  
end