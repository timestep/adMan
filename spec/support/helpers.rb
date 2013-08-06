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
		fill_in('date-picker', :with => '05/07/2013')
		select(page.name, :from => "query_page_id")
		click_button("Search")
	end

	def visit_new_page_path
		login(@user_attributes)
		current_path.should == bookings_path
		# page.find('#pages').trigger(:hover)
		click_link("Add New Page")
		current_path.should == new_page_path
	end

	def visit_new_client_path
		login(@user_attributes)
		current_path.should == bookings_path
		# page.find('#client').trigger(:hover)
		click_link("Add New Client")
		current_path.should == new_client_path
	end
end