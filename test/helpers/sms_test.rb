require 'test_helper'

class SmsTest < ActionView::TestCase

  test "basic api usage" do
    #HEROKU HACK:
    ENV['URL'] = "gladys-example.herokuapp.com"

    client = mock
    messages = mock

    Sms.expects(:client).returns(client)
    client.expects(:messages).returns(messages)
    messages.expects(:create).with(from: '+14159341234', to: '+15551234567',
                                   body: 'Daily study questions: http://gladys-example.herokuapp.com/d/this-is-a-token')

    Sms.notify("+15551234567", "this-is-a-token")
  end

end
