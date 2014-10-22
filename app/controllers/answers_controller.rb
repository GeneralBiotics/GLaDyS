class AnswersController < ApplicationController
  def demo
    @token = Participant.all.first.tokens.create
    redirect_to "/d/#{@token.value}"
  end

  def daily
    @token = Token.find_by(value: params[:token])

    if @token.nil?
      raise ActionController::RoutingError.new('Not Found')
    end

    @previous_answers = @token.answers
    @questions = Question.all
  end

  def mark
    @token = Token.find_by(value: params[:token])

    if request.post?
      params[:questions].to_a.each do |id, v|
        @token.answers.mark!(id, v)
      end

      if @token.valid?
        redirect_to "/thanks"
        return
      end
    end

    redirect_to "/d/#{@token.value}"
  end

  def thanks
  end
end

