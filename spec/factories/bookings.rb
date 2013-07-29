# Read about factories at https://github.com/thoughtbot/factory_girl
require 'date'

FactoryGirl.define do
  factory :booking do
    date Date.today
    user 1
    client {rand(1..20)}
    page {rand(1..5)}
  end
end
