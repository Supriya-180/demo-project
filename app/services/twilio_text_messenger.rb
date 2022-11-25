class TwilioTextMessenger
  attr_reader :message

  def initialize(message, phone_number)
    @message = message
    @phone_number = phone_number
  end

  def call
    client = Twilio::REST::Client.new
    # byebug
    client.messages.create({
      from: ENV["twilio_phone_number"],
      to: "+91#{@phone_number}",  # +91{'989898998'}
      body: @message
    })
  end
end

