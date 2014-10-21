require 'securerandom'

class Token < ActiveRecord::Base
  belongs_to :participant
  has_many :answers do
    def mark(question, value)
      a = new
      a.question = question
      a.value = value
      a
    end

    def mark!(question, value)
      a = mark(question, value)
      a.save
      a
    end
  end

  validates_presence_of :participant_id

  before_create :init_uuid
  before_update :block_action
  before_destroy :block_action

  private
  def init_uuid
    self.value ||= SecureRandom.uuid
  end

  def block_action
    false
  end
end
