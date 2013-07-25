require 'spec_helper'

describe "Visitor" do 
	it {should visit root_path}
	it {should have_selector('form')}
end
