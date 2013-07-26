require 'spec_helper'

describe "User" do 

	it {should visit root_path}
	
	before :each do
		@user_attributes = FactoryGirl.attributes_for(:user)
		@user = User.create(@user_attributes)
		visit root_path
	end

	context 'in log-in phase' do
		it "attempts successful login" do
			should visit login_path
			fill_in('Email', :with => @user_attributes[:email])
			fill_in('Password', :with => @user_attributes[:password])
			click_button('Log In')
			page.should have_text("Logged in~!")
			page.should have_text("Welcome to the bookings page!!")
			page.should have_text("Log Out")
		end

		it "attempts failed login" do
			should visit login_path
			fill_in('Email', :with => 'hoopla')
			fill_in('Password', :with => 'hola')
			click_button('Log In')
			page.should have_text('Email or password was invalid')
		end
	end

	context 'while logged in' do
		it "log out" do
			should visit login_path
			fill_in('Email', :with => @user_attributes[:email])
			fill_in('Password', :with => @user_attributes[:password])
			click_button('Log In')
			click_link("Log Out")
			# expect(response.status).to eq(200)	
		end
	end
end