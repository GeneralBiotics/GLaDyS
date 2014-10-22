class Daily < ActionMailer::Base
  default from: "from@example.com"

  def notify(participant, token)
    @participant = participant
    token = token.value if token.is_a? Token

    # TODO - heroku hack
    app_name = ENV['URL'].split(".").first
    @url = "http://#{app_name}.herokuapp.com/d/#{token}"

    mail(to: @participant.email, subject: 'Daily study questions')
  end
end
