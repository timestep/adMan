require 'spec_helper'

describe "Visitor" do 
	context "should visit home page"
		it {should visit root_path}
	end
	context "should be able to see log in page with form"
		it {should have_selector('form')}
		it {should have_link('Log In')}
	end
end
