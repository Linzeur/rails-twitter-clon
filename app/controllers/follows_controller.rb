class FollowsController < ApplicationController
  def index
    follows = Follow.select("id, follower_id, followed_id").where(follower_id: params[:user_id])
    render json: follows
  end

  def create
    follow = Follow.create(follower_id: params[:user_id], followed_id: params[:followed_id])
    render json: follow, status: :created
  end

  def destroy
    follow = Follow.find(params[:id])
    follow.destroy
    render nothing: true, status: :no_content
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end
end