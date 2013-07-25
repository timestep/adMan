require 'spec_helper'

describe "Visitor" do 
	context "should visit home page" do
		it {should visit root_path}
	end
	context "should be able to see log in page with form" do
		it {should have_selector('form')}
		it {should have_link('Log In')}
	end
end
