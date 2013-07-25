require 'spec_helper'

describe "User" do 

	it {should visit root_path}
	
	before :each do
		@user_attributes = FactoryGirl.attributes_for(:user)
		@user = User.create(@user_attributes)
		visit root_path
	end

	context 'in log phase' do
		it "attempts successful login" do
			fill_in('Email', :with => @user_attributes[:email])
			fill_in('Password', :with => @user_attributes[:password])
			click_button('Log in')
			should have_text("Logged in!")
		end

		it "attempts failed login" do
		end
	end
end