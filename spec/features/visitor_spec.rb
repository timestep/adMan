require 'spec_helper'

describe "Visitor" do 
	context "should visit home page" do
		it {should visit root_path  "visits root path"}
		it {should visit login_path}
	end
	context "should be able to see log in page" do
		it 'sees form and login button' do
			visit root_path
			# print page.html
			page.should have_selector('form')
			page.should have_button('Log In')
		end
	end
	context "attempts unauthorized access" do
		it "will render login page and warning" do 
			visit root_path
			visit bookings_path
			page.should have_content("First login to access this page.")
		end
	end
end
