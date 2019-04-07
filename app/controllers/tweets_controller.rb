#Tweets Required attributes: id, user_id, text, likes(number), replies(number)
class TweetsController < ApplicationController
  def index
    tweets = Tweet.select("id, content, user_id").where(tweet_id: nil).map do |row|
      new_hash = Hash.new
      new_hash[:replies] = Tweet.where(tweet_id:row.id).size
      new_hash[:likes] = Like.where(tweet_id:row.id).size
      row.counts = Hash.new
      row.counts = new_hash
      row
    end
    render json: tweets, methods: [:counts]
  end

  def show
    tweet_founded = Tweet.find(params[:id])
    new_hash = Hash.new
    new_hash[:replies] = tweet_founded.tweets.size
    new_hash[:likes] = tweet_founded.likes.size
    tweet_founded.counts = new_hash
    render json: tweet_founded, methods: [:counts]
  end

  def create
    tweet = Tweet.create(content: params[:content], user_id: params[:user_id])
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
    new_hash = Hash.new
    new_hash[:replies] = tweet.tweets.size
    new_hash[:likes] = tweet.likes.size
    tweet.counts = new_hash
    render json: tweet, methods: [:counts]
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