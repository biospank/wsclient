# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    password { Faker::Internet.password }
  end
  
  factory :wsuser, class: User do
    username ENV['WORKSHARE_APP_KEY']
    password ENV['WORKSHARE_APP_SECRET']
  end
  
end
