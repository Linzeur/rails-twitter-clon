class RepliesController < ApplicationController
 

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

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    render nothing: true, status: :no_content
  end
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end
end

