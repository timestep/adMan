module Helpers
	def login(user)
		visit login_path
		current_path.should == login_path
		fill_in('Email', :with => user[:email])
		fill_in('Password', :with => user[:password])
		click_button('Log In')
	end

	def valid_query 
		page = FactoryGirl.create(:page)
		login(@user_attributes)
		click_link("Look Up")
		current_path.should == query_bookings_path
		fill_in('date-picker',  :with => '05/07/2013')
		select(page.name, :from => "params[page_id]")
		click_button("Search")
	end
end