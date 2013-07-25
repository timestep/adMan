require 'spec_helper'

describe "User" do 
	it {should visit root_path}
	
	@user_attributes = FactoryGirl.attributes_for(:user)
	@user = User.create(@user_attributes)
	
	context "attempts successful login" do
		fill_in('Email', :with => @user_attributes[:email])
		fill_in('Password', :with => @user_attributes[:password])
		click_button('Log in')
		it{should have_text("Logged in!")}
	end
	context "attempts failed login" do
	end

end