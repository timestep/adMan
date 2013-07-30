require 'date'

FactoryGirl.define do
  factory :booking do
    date Date.today
    association :user, :factory => :user
    association :client, :factory => :client

    pages {
    	[ FactoryGirl.create(:page) ]
    }
  end
end
