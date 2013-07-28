require 'spec_helper'

describe "User" do 

	it {should visit root_path}
	
	before :each do
		@user_attributes = FactoryGirl.attributes_for(:user)
		@user = User.create(@user_attributes)
		visit root_path
	end

	context 'in log-in phase' do
		it "can successfully login" do
			login(@user_attributes)
			page.should have_text("Logged in~!")
			page.should have_text("Welcome to the bookings page!!")
			page.should have_text("Log Out")
		end

		it "can fail to login" do
			@user_attributes = FactoryGirl.attributes_for(:user, :email => "hoopla", :password => "nope" )
			login(@user_attributes)
			page.should have_text('Email or password was invalid')
		end
	end

	context 'while logged in' do
		it "log out" do
			login(@user_attributes)
			click_link("Log Out")
			# expect(response.status).to eq(200)	
		end

		it "can see a list of all the bookings" do
			page.should have_text("List of Bookings")
			#Need to check that all bookings are showing on this page
		end

		it "can navigate to the 'query page'" do
			login(@user_attributes)
			click_link("Look Up")
		end

		it "can navigate to 'add new pages' page" do
			login(@user_attributes)
			click_link("Add New Page")
		end

		it "can navigate to 'add new client' page" do
			login(@user_attributes)
			click_link("Add New Client")
		end
	end
	context 'while logged in and on add new client page' do
		it "successfully adds a new client" do
			login(@user_attributes)
			click_link("Add New Client")
			@client = FactoryGirl.create(:client)
			fill_in('Name', :with => @client[:name])
			click_button("Add Client")
		end
	end

	context 'while logged in and on add new pages page' do
		it "successfully adds a new page" do
			login(@user_attributes)
			click_link("Add New Page")
			@page = FactoryGirl.create(:page)
			fill_in('URL', :with => @page[:slug])
			fill_in('Name', :with => @page[:name])
			click_button("Add Page")
		end
	end
end