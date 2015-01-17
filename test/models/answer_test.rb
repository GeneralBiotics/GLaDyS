require 'test_helper'

class AnswerTest < ActiveSupport::TestCase

  def setup
    # bypass the before_update filter
    Participant.where('id = ?', participants(:one).id).update_all(
      completed: false,
      drop_out: false,
      drop_out_reason: nil
    )
  end

  def token
    participants(:one).tokens.create
  end

  test "easy creation through tokens" do
    t = token
    a = t.answers.mark!(questions(:one), "218")

    assert a.id
    assert a.participant, participants(:one)
    assert t, a.token
    assert "218", a.value
  end

  test "you can only answer questions repeatedly" do
    t = token

    a = t.answers.mark!(questions(:one), "218")
    assert a.id
    assert_equal "218", a.value

    a2 = t.answers.mark!(questions(:one), "216")
    assert_equal a.id, a2.id
    assert_equal "216", a2.value

    a3 = t.answers.mark!(questions(:one).id, "214")
    assert_equal a.id, a3.id
    assert_equal "214", a3.value

    a4 = t.answers.mark!(questions(:one).id.to_s, "212")
    assert_equal a.id, a4.id
    assert_equal "212", a4.value
  end

  test "double validation" do
    ["218", "7", "0", "218.711"].each do |e|
      assert token.answers.mark!(questions(:one), e).valid?
    end
  end

  test "double validation fail" do
    assert !token.answers.mark!(questions(:one), "seven").valid?
  end

  test "boolean validation" do
    ["true", "false"].each do |e|
      assert token.answers.mark!(questions(:three), e).valid?
    end
  end

  test "boolean validation fail" do
    assert !token.answers.mark!(questions(:three), "seven").valid?
  end

  test "select validation" do
    ["25%", "50%", "60%", "25%"].each do |e|
      assert token.answers.mark!(questions(:two), e).valid?
    end
  end

  test "select validation fail" do
    assert !token.answers.mark!(questions(:two), "218").valid?
  end

  test "can not be destroyed" do
    a = token.answers.mark!(questions(:three), "true")
    assert !a.destroy
  end

  test "new questions can be updated" do
    a = token.answers.mark!(questions(:three), "true")
    assert a.id

    a.value = "false"
    assert a.save
  end

  test "old questions can not be updated" do
    a = token.answers.mark!(questions(:three), "true")
    assert a.id

    a.created_at = 3.days.ago
    a.value = "false"
    assert !a.save
  end

  test "completed users can not change answers" do
    a = token.answers.mark!(questions(:three), "true")
    assert a.id

    a.participant.completed = true
    a.value = "false"
    assert !a.save
  end

  test "dropped out users can not change answers" do
    a = token.answers.mark!(questions(:three), "true")
    assert a.id

    a.participant.drop_out = true
    a.value = "false"
    assert !a.save
  end

end
