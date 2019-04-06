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
    puts users.to_s
    render json: users, methods: [:counts]
  end

  def show
    user_founded = User.find(params[:id])
    new_hash = Hash.new
    new_hash[:followers] = user_founded.followers.size
    new_hash[:follows] = user_founded.follows.size
    user_founded.counts = new_hash
    puts user_founded.methods.sort.to_s
    render json: user_founded, methods: [:counts]
  end

  def create
    user = User.create(name: params[:name])
    render json: user, status: :created
  end

  def update
    user = User.find(params[:id])
    params.keys.each do |key|
      if key != :id && user.attributes.key?(key)
        user[key] = params[key]
      end
    end
    user.save
    render json: user
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    render nothing: true, status: :no_content
end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

end