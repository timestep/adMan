require 'spec_helper'

describe "User" do 

	it {should visit root_path}
	
	before :each do
		@user_attributes = FactoryGirl.attributes_for(:user)
		@user = User.create(@user_attributes)
		visit root_path
	end

	context 'in log-in phase' do
		it "can successfully login" do
			login(@user_attributes)
			page.should have_text("Logged in~!")
			page.should have_text("Welcome to the bookings page!!")
			page.should have_text("Log Out")
		end

		it "can fail to login" do
			@user_attributes = FactoryGirl.attributes_for(:user, :email => "hoopla", :password => "nope" )
			login(@user_attributes)
			page.should have_text('Email or password was invalid')
		end
	end

	context 'while logged in' do
		it "log out" do
			login(@user_attributes)
			click_link("Log Out")
			# expect(response.status).to eq(200)	
		end
	end
end