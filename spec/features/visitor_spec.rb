require 'spec_helper'

describe "Visitor" do 
	context "should visit home page" do
		it {should visit root_path}
		it {should visit login_path}
	end
	context "should be able to see log in page" do
		it 'sees form and login button' do
			visit root_path
			print page.html
			should have_field('email')
			should have_field('password')
			should have_button('Log In')
		end
	end
end
