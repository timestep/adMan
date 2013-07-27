# Read about factories at https://github.com/thoughtbot/factory_girl
require 'date'

FactoryGirl.define do
  factory :booking do
    date {Date.today - rand(500)}
    user {rand(1..5)}
    client {rand(1..20)}
    page {rand(1..5)}
  end
end
