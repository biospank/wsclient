# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    password { Faker::Internet.password }
  end
end
