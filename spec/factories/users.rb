FactoryGirl.define do
	sequence :email do |n|
		"email#{n}@test.com"
	end
  
  factory :user do
  	email
  	password 'password'
  end
end