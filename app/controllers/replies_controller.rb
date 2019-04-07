class RepliesController < ApplicationController
  def index
    Tweet.where.not("tweet_id"=> nil)
    render nothing: true, status: :ok
  end

  def show
    render json: Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    params.keys.each do |key|
      if key != :id && tweet.attributes.key?(key)
        tweet[key] = params[key]
      end
    end
    tweet.save
    render json: tweet
  end

  # def destroy
  #   product = Product.find(params[:id])
  #   product.destroy
  #   render nothing: true, status: :no_content
  # end
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end
end

