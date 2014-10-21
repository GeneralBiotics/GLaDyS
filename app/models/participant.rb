class Participant < ActiveRecord::Base
  has_many :tokens
  has_many :answers

  before_update :dropout_values_editible_one_time
  before_destroy :block_action

  def drop_out!(msg = "")
    self.drop_out = true
    self.drop_out_reason = msg
    self.save
  end

  private
  def block_action
    false
  end

  def dropout_values_editible_one_time
    all_attrs = changed
    allowed_attrs = all_attrs & ["drop_out", "drop_out_reason", "updated_at"]

    if all_attrs == allowed_attrs && !drop_out_was
      self.drop_out = true
      true
    else
      false
    end
  end

end
