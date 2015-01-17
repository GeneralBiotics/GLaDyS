require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  def setup
    # bypass the before_update filter
    Participant.where('id = ?', participants(:one).id).update_all(
      completed: false,
      drop_out: false,
      drop_out_reason: nil
    )
  end

  test "participants are not deletable" do
    p = participants(:one)

    assert !p.destroy
    p.reload

    assert p.id
  end

  test "participants are not editable except for dropping out" do
    p = participants(:one)
    p.first_name = "not declared first name"
    assert !p.save
    p.reload

    assert_equal "Foo", p.first_name
  end

  test "participants can drop out" do
    p = participants(:one)

    assert !p.drop_out
    p.drop_out = true
    p.save
    p.reload

    assert p.drop_out
  end

  test "participants can only drop out once" do
    p = participants(:one)
    assert p.drop_out!("some reason")

    p.reload
    assert !p.drop_out!("some OTHER reason")

    p.reload
    assert_equal "some reason", p.drop_out_reason
  end

  test "participants can complete" do
    p = participants(:one)

    assert !p.drop_out
    p.drop_out = true
    assert p.save
    p.reload

    assert p.drop_out
  end

  test "participants can not uncomplete" do
    p = participants(:one)

    assert !p.completed
    p.completed = true
    assert p.save
    p.reload

    p.completed = false
    assert !p.save
  end

end
