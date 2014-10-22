require 'test_helper'

class TokensTest < ActiveSupport::TestCase
  test "creates values, sets created_at" do
    t = participants(:one).tokens.create

    assert t.value
    assert t.created_at
  end

  test "can not be updated" do
    t = participants(:one).tokens.create

    t.value = "different"
    assert !t.save
  end

  test "can not be destroyed" do
    t = participants(:one).tokens.create
    assert !t.destroy
  end

  test "knows if all questions have been answered with this token" do
    t = participants(:one).tokens.create
    assert !t.all_questions_answered?

    Question.all.each do |e|
      if e.options_for_select
        t.answers.mark!(e, e.options_for_select[0])
      else
        t.answers.mark!(e, "2")
        t.answers.mark!(e, "false")
      end
    end
    assert t.all_questions_answered?
  end
end
