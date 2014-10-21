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
end
