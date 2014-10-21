class Question < ActiveRecord::Base
  has_many :answers

  serialize :options_for_select

  before_update :block_action
  before_destroy :block_action

  private
  def block_action
    false
  end
end
