module AnswersHelper
  def answer_for_question(q)
    a = @previous_answers.find {|e| e.question_id == q.id }
    (a && a.value) || ""
  end
end
