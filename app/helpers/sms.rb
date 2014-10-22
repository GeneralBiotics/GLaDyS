class Sms

  def self.notify(phone_number, token)
    # TODO - heroku hack
    app_name = ENV['URL'].split(".").first
    url = "http://#{app_name}.herokuapp.com/d/#{token}"

    # TODO - temp hack
    from_number = '+14159341234'

    client.messages.create(
      from: from_number,
      to: phone_number,
      body: "Daily study questions: #{url}"
    )
  end

  def self.client
    Twilio::REST::Client.new
  end

end
