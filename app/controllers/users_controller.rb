class UsersController < ApplicationController
  def index
    render json: User.all, status: :ok
  end

  def show
    render json: User.find(params[:id])
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

end