# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    password { Faker::Internet.password }
  end
  
  factory :wsuser, class: User do
    username { 'fabio.petrucci@gmail.com' }
    password { 'workshare9571' }
  end
  
end
