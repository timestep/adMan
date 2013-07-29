module Helpers
	def login(user)
		visit login_path
		current_path.should == login_path
		fill_in('Email', :with => user[:email])
		fill_in('Password', :with => user[:password])
		click_button('Log In')
	end
end