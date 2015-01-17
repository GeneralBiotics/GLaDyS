class Answer < ActiveRecord::Base
  delegate :participant, to: :token
  belongs_to :question
  belongs_to :token

  validates_uniqueness_of :token_id, scope: :question_id

  validate :participant_is_active
  validate :answer_matches_format
  before_update :block_old_updates
  before_destroy :block_action

  private
  def participant_is_active
    unless participant.active?
      errors.add(:participant, "must be active")
    end
  end

  def answer_matches_format
    self.send("answer_matches_#{question.format}_format")
  end

  def answer_matches_double_format
    unless (value.to_f.to_s == value) || (value.to_i.to_s == value)
      errors.add(:value, "must be a number")
    end
  end

  def answer_matches_select_format
    unless question.options_for_select.include?(value)
      errors.add(:value, "must be a true or false")
    end
  end

  def answer_matches_boolean_format
    unless ["true", "false"].include?(value)
      errors.add(:value, "must be a true or false")
    end
  end

  def block_old_updates
    created_at > 16.hours.ago
  end

  def block_action
    false
  end
end

