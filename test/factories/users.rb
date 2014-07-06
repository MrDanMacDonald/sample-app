# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    password 'some_password'
    password_confirmation 'some_password'
  end
end
