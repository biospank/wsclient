# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :wsession, class: Api::WorkShare::V1::Session do
    ignore do
      key ENV['WORKSHARE_APP_KEY']
      secret ENV['WORKSHARE_APP_SECRET']
    end
    
    initialize_with { new(key, secret) }

  end

end
