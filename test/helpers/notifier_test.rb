require 'test_helper'

class NotifierTest < ActionView::TestCase

  # integration testing, for more detailed tests see the Sms and
  # Notifier unit tests

  test "notifier creates and sends tokens to all participants" do
    #HEROKU HACK:
    ENV['URL'] = "gladys-example.herokuapp.com"

    starting_tokens = Token.count

    Sms.expects(:notify).with('+15551234567', kind_of(String)).returns(nil)
    Notifier.daily_notification

    assert_equal (starting_tokens + 2), Token.count

    assert_not ActionMailer::Base.deliveries.empty?
    email = ActionMailer::Base.deliveries.last
    assert_equal ['foo2@example.com'], email.to
  end

end
