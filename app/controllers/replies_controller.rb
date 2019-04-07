class RepliesController < ApplicationController
  def index
    render json: Tweet.where.not(tweet_id: nil)
  end

  def show
    render json: Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    params.keys.each do |key|
      if key != :id && tweet.attributes.key?(key) && key != :user_id
        tweet[key] = params[key]
      end
    end
    tweet.save
    render json: tweet
  end

  def create
    tweet = Tweet.create(content: params[:content],user_id: params[:user_id],tweet_id: params[:tweet_id])
    render json: tweet, status: :created
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

