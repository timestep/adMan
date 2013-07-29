# Read about factories at https://github.com/thoughtbot/factory_girl
require 'date'

FactoryGirl.define do
  factory :booking do
    date Date.today
    association :user, :factory => :user
    association :client, :factory => :client
    association :page, :factory => :page
  end
end
