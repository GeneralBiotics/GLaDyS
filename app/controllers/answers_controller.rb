class AnswersController < ApplicationController
  before_filter :load_token, except: :demo

  def demo
    @token = Participant.all.first.tokens.create
    redirect_to "/d/#{@token.value}"
  end

  def daily
    @previous_answers = @token.answers
    @questions = Question.all
  end

  def mark
    if request.post?
      params[:questions].to_a.each do |id, v|
        @token.answers.mark!(id, v)
      end

      if @token.valid? && @token.all_questions_answered?
        redirect_to "/thanks/#{@token.value}"
        return
      end
    end

    redirect_to "/d/#{@token.value}"
  end

  def thanks
  end

  private
  def load_token
    @token = Token.find_by(value: params[:token])

    if @token.nil?
      render_404
    end
  end
end

