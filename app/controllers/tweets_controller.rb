#Tweets Required attributes: id, user_id, text, likes(number), replies(number)
class TweetsController < ApplicationController
  def index
    render json: Tweet.where(tweet_id = nil), status: :ok
  end

  def show
    render json: Tweet.find(params[:id])
  end

  def create
    tweet = Tweet.create(content: params[:content])
    render json: tweet, status: :created
  end

  def update
    tweet = Tweet.find(params[:id])
        params.keys.each do |key|
      if key != :id && key != :user_id && tweet.attributes.key?(key)
        tweet[key] = params[key]
      end
    end
    tweet.save
    render json: tweet
  end
  
  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    render nothing: true, status: :no_content
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

end