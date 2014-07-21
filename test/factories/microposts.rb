require 'faker' 

FactoryGirl.define do 
  factory :micropost do 
    content Faker::Lorem.characters(139)
    user
  end
end