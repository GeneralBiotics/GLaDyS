require 'test_helper'

class DailyTest < ActionMailer::TestCase
  test "basic api usage" do
    #HEROKU HACK:
    ENV['URL'] = "gladys-example.herokuapp.com"

    p = participants(:two)
    t = p.tokens.create
    Daily.notify(p, t).deliver

    assert_not ActionMailer::Base.deliveries.empty?
    email = ActionMailer::Base.deliveries.last

    assert_equal ['foo2@example.com'], email.to
    assert_equal ['from@example.com'], email.from
    assert_equal 'Daily study questions', email.subject
    assert email.body.to_s =~ /#{t.value}/
  end
end
