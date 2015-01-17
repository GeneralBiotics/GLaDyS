require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "questions can't be destroyed" do
    q = questions(:one)
    assert !q.destroy
    q.reload
  end

  test "questions can't be updated" do
    q = questions(:one)
    assert_equal "double", q.format

    q.format = :test
    assert !q.save
    q.reload

    assert_equal "double", q.format
  end
end
