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
			current_path.should == bookings_path
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
			current_path.should == bookings_path
			click_link("Log Out")
			# expect(response.status).to eq(200)	
		end

		it "can see a list of all the bookings on the bookings page" do
			login(@user_attributes)
			current_path.should == bookings_path

			#Need to check that all bookings are showing on this page
		end

		it "can navigate to 'add new pages' page" do
			login(@user_attributes)
			click_link("Add New Page")
			current_path.should == new_page_path
		end

		it "can navigate to 'add new client'page" do
			login(@user_attributes)
			click_link("Add New Client")
			current_path.should == new_client_path
		end

	end

	context 'while logged in and on add new client page' do
		it "successfully adds a new client" do
			login(@user_attributes)
			click_link("Add New Client")
			c = FactoryGirl.build(:client)
			fill_in('Name', :with => c[:name])
			print page.html
			click_button("Add Client")
			current_path.should == bookings_path
		end
	end

	context 'while logged in and on add new pages page' do
		it "successfully adds a new page" do
			login(@user_attributes)
			click_link("Add New Page")
			p = FactoryGirl.build(:page)
			fill_in('Name', :with => p[:name])
			fill_in('URL', :with => p[:slug])
			click_button("Add Page")
			current_path.should == bookings_path
		end
	end


	context	"while logged in and on index page" do
		it 'can successfully query for a booking' do
			valid_query
			current_path.should == new_booking_path
		end

		it 'can unsuccessfully query and be redirected to query again' do
			page = FactoryGirl.create(:page)
			login(@user_attributes)
			click_link("Look Up")
			fill_in('date-picker', :with => nil)
			select(page.name, :from => "query[page_id]")
			click_button("Search")
			current_path.should == search_bookings_path
		end

		it 'can query without entering the page field and be redirected to query again' do
			booking = FactoryGirl.create(:booking)
			login(@user_attributes)
			click_link("Look Up")
			fill_in('date-picker', :with => booking.date.strftime("%m/%d/%Y"))
			# fill_in('page', :with => booking.page)
			# fill_in('client', :with => booking.client)
			click_button("Search")
			current_path.should == search_bookings_path
		end

		it 'can query for an existing date and be redirected to query again' do
			booking = FactoryGirl.create(:booking)
			login(@user_attributes)
			click_link("Look Up")
			fill_in('date-picker', :with => booking.date.strftime("%m/%d/%Y"))
			select(booking.pages.name, :from => "query[page_id]")
			# binding.pry
			click_button("Search")
			current_path.should == booking_path(booking.id)
			page.should have.text(booking.pages.name)
		end
	end	
	context	"while query page and successfully queried" do
		it 'add a booking' do
			client = FactoryGirl.create(:client)
			valid_query
			current_path.should == new_booking_path
			select(client.name, :from => "booking[client_id]")
			# fill_in('Contract Number', :with => "contractnumber")
			# fill_in('Additional Information' :with => additionalinfo)
			click_button("Book Now")
			current_path.should == booking_path(Booking.last.id)
		end
	end
end