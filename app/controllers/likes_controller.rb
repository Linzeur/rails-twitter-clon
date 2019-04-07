class LikesController < ApplicationController
  def index
    likes = Like.select("id, user_id, tweet_id")
    render json: likes
  end

  def show
    like_founded = Like.find(params[:id])
    render json: like_founded
  end

  def create
    like = Like.create(user_id: params[:user_id], tweet_id: params[:tweet_id])
    render json: like, status: :created
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    render nothing: true, status: :no_content
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

end