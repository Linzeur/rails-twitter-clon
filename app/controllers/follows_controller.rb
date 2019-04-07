class FollowsController < ApplicationController
  def create
    follow = Follow.create(follower_id: params[:user_id], followed_id: params[:followed_id])
    render json: follow, status: :created
  end
end