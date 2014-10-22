require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  def setup
    @token = participants(:one).tokens.create
  end

  test "requires a real token to see daily questions" do
    get :daily, :token => "not_real"
    assert_response :missing
  end

  test "renders questions for valid tokens" do
    get :daily, :token => @token.value
    assert_response :success
  end


  test "marking requires a non-false token" do
    post :mark, :token => "not_real"
    assert_response :missing
  end

  test "incomplete marking sends you back to the daily questions list" do
    post :mark, :token => @token.value
    assert_redirected_to(:action => :daily, :token => @token.value)
#    assert_redirected_to(:action => :thanks, :token => @token.value)
  end

  test "complete marking sends you to the thank you page" do
    post :mark, :token => @token.value, :questions => {
      1 => "218",
      2 => "25%",
      3 => "true"
    }
    assert_redirected_to(:action => :thanks, :token => @token.value)
  end


  test "no thanks for the false tokens" do
    get :thanks, :token => "not_real"
    assert_response :missing
  end

  test "thanks for the tokenful" do
    get :thanks, :token => @token.value
    assert_response :success
  end
end
