require 'securerandom'

class Token < ActiveRecord::Base
  belongs_to :participant
  has_many :answers do
    def mark(question, value)
      if question.is_a? Question
        a = find_by(question: question)
        a ||= new
        a.question = question
      else
        a = find_by(question_id: question)
        a ||= new
        a.question_id = question
      end
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

  def all_questions_answered?
    (Question.all - answers.all.map{|e| e.question}).length == 0
  end

  private
  def init_uuid
    self.value ||= SecureRandom.uuid
  end

  def block_action
    false
  end
end
