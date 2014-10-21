require 'test_helper'

class AnswerTest < ActiveSupport::TestCase

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

  test "you can only answer questions once" do
    t = token

    assert t.answers.mark!(questions(:one), "218").valid?
    assert !t.answers.mark!(questions(:one), "218").valid?
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
end
