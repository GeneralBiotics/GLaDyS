class AnswersController < ApplicationController
  def daily
    @token = Token.find_by(value: params[:token])

    if @token.nil?
      raise ActionController::RoutingError.new('Not Found')
    end

    @previous_answers = @token.answers
    @questions = Question.all

    if request.post?
      # save results...
    else
    end
  end

  def thanks
  end
end

