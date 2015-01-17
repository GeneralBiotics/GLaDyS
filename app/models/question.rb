class Question < ActiveRecord::Base
  has_many :answers

  serialize :options_for_select

  before_update :block_action
  before_destroy :block_action

  def self.daily ; load_frequency("daily") ; end
  def self.opening ; load_frequency("opening") ; end
  def self.closing ; load_frequency("closing") ; end

  private
  def self.load_frequency(frequency)
    self.where(frequency: frequency).order(:ordering)
  end

  def block_action
    false
  end
end
