# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :wsession, class: Api::WorkShare::V1::Session do
    ignore do
      key 'fabio.petrucci@gmail.com'
      secret 'workshare9571'
    end
    
    initialize_with { new(key, secret) }

  end

end
