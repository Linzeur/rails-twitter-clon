#Tweets Required attributes: id, user_id, text, likes(number), replies(number)
class TweetsController < ApplicationController
  def index
    render json: Tweet.where(tweet_id = nil), status: :ok
  end

  def show
    render json: Tweet.find(params[:id])
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

end