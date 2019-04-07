class UsersController < ApplicationController
  def index
    users = User.select("id, name, description,image_url,country,url").map do |row|
              new_hash = Hash.new
              new_hash[:followers] = Follow.where(follower_id:row.id).size
              new_hash[:follows] = Follow.where(followed_id:row.id).size
              row.counts = Hash.new
              row.counts = new_hash
              row
            end    
    render json: users, methods: [:counts]
  end

  def show
    user_founded = User.find(params[:id])
    new_hash = Hash.new
    new_hash[:followers] = user_founded.followers.size
    new_hash[:follows] = user_founded.follows.size
    user_founded.counts = new_hash
    render json: user_founded, methods: [:counts]
  end

  def create
    user = User.create(name: params[:name], username: params[:username], country: params[:country])
    render json: user, status: :created
  end

  def update
    user_founded = User.find(params[:id])
    params.keys.each do |key|
      if key != :id && user_founded.attributes.key?(key)
        user_founded[key] = params[key]
      end
    end
    user_founded.save
    new_hash = Hash.new
    new_hash[:followers] = user_founded.followers.size
    new_hash[:follows] = user_founded.follows.size
    user_founded.counts = new_hash
    render json: user_founded
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render nothing: true, status: :no_content
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

end