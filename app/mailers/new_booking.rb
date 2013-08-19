class NewBooking < ActionMailer::Base
  default from: "from@example.com"

  def new_booking(user,booking)
    @user = user
    @booking = booking
    mail(to: @user.email, subject: 'New Booking')
  end
end
