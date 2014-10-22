require 'test_helper'
require 'ostruct'

class AnswersHelperTest < ActionView::TestCase
  include AnswersHelper

  test "accurately query previous answers from a collection" do
    @previous_answers = [{question_id: 1, value: 11}, {question_id: 2, value: 22},
                         {question_id: 3, value: 33}].map {|e| OpenStruct.new(e)}

    [1, 2, 3].each do |e|
      assert_equal e * 11, answer_for_question(OpenStruct.new({id: e}))
    end

    assert_equal "", answer_for_question(OpenStruct.new({id: 4}))
  end

end
