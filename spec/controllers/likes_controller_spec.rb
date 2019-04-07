require 'rails_helper'

describe LikesController do
  before do
    Like.delete_all
  end

  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'render json with all likes' do
      user = User.create(
        name: 'Angie',
        username: 'AngieC',
        description: 'Aprendiendo a codear'
      )
      tweet = Tweet.create(
        content: 'Testeando tweets!', 
        user_id: user.id
      )
      Like.create(user_id: user.id, tweet_id: tweet.id)
      get :index
      likes = JSON.parse(response.body)
      expect(likes.size).to eq 1
    end
  end

  describe 'GET show' do
    it 'returns http status ok' do
      user = User.create(
              name: "Deyvi",
              username: 'deyconde',
              description: 'Mi pelucaaaaa'
            )
      tweet = Tweet.create(
                content: 'Estoy testeando show!',
                user_id: user.id
              )
      comment = Tweet.create(
                content: 'Yo tambien en comentarios',
                user_id: user.id,
                tweet_id: tweet.id
              )
      like = Like.create(user_id: user.id, tweet_id: comment.id)
      get :show, params: { id: like.id }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct like' do
      user = User.create(
              name: "Deyvi",
              username: 'deyconde',
              description: 'Chico Codeable'
            )
      tweet = Tweet.create(
                content: 'Probando Tweet!',
                user_id: user.id
              )
      comment = Tweet.create(
                content: 'Primer comentario',
                user_id: user.id,
                tweet_id: tweet.id
              )
      like = Like.create(user_id: user.id, tweet_id: comment.id)
      get :show, params: { id: like.id }
      expected_like = JSON.parse(response.body)
      expect(expected_like["id"]).to eq(like.id)
    end

    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST create" do
    it "returns http status created" do
      user = User.create(
              name: 'Angie',
              username: 'AngieC',
              description: 'Aprendiendo a codear'
            )
      tweet = Tweet.create(
                content: 'Estoy mostrando el correcto tweet',
                user_id: user.id
              )
      comment = Tweet.create(
                content: 'Hola',
                user_id: user.id,
                tweet_id: tweet.id
              )
      post :create, params: { user_id: user.id, tweet_id: tweet.id }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it "returns the created like" do
      
      user = User.create(
                name: 'Carlos',
                username: 'CarlitosS',
                description: 'Firebase Rules!!'
              )
      tweet = Tweet.create(
                content: 'Estoy mostrando el correcto tweet',
                user_id: user.id
              )
      comment = Tweet.create(
                content: 'Hola',
                user_id: user.id,
                tweet_id: tweet.id
              )
      post :create, params: { user_id: user.id, tweet_id: comment.id }
      expected_user = JSON.parse(response.body)
      expect(expected_user).to have_key("id")
      expect(expected_user["user_id"]).to eq(user.id)
      expect(expected_user["tweet_id"]).to eq(comment.id)
    end
  end

  describe "DELETE destroy" do
    it "returns http status no content" do
      user = User.create(
              name: 'Angie',
              username: 'AngieC',
              description: 'Aprendiendo a codear'
            )
      tweet = Tweet.create(
                content: 'Este tweet ha sido creado!',
                user_id: user.id
              )
      comment = Tweet.create(
                content: 'Este comentario ha sido creado!',
                user_id: user.id,
                tweet_id: tweet.id
              )
      like = Like.create(user_id: user.id, tweet_id: tweet.id)
      delete :destroy, params: { id: like.id }
      expect(response).to have_http_status(:no_content)
    end

    it "returns empty body" do
      user = User.create(
              name: "Usuario 1",
              username: "userTest",
              description: "Soy un nuevo usuario de prueba",
              country: "Peru"
            )
      tweet = Tweet.create(
                content: 'Este tweet se debe mostrar',
                user_id: user.id
              )
      comment = Tweet.create(
                content: 'Estoy testeando comentario!',
                user_id: user.id,
                tweet_id: tweet.id
              )
      like = Like.create(user_id: user.id, tweet_id: comment.id)
      delete :destroy, params: { id: like }
      expect(response.body).to eq(" ")
    end

    it "decrement by 1 the total of likes" do
      user = User.create(
              name: "Usuario 2",
              username: "test456",
              description: "Soy otro nuevo usuario de prueba para twitter",
              country: "Bolivia",
              url: "http://www.twitter.com/usu2.456"
            )
      tweet = Tweet.create(
                content: 'Testing DELETE method!',
                user_id: user.id
              )
      comment = Tweet.create(
                content: 'Testing DELETE method! comentario',
                user_id: user.id,
                tweet_id: tweet.id
              )
      like = Like.create(user_id: user.id, tweet_id: tweet.id)
      expect do
        delete :destroy, params: { id: like }
      end.to change { Like.count }.by(-1)
    end

    it "actually delete the like" do
      user = User.create(
              name: "Deyvi",
              username: 'deyconde',
              description: 'Mi segunda prueba'
            )
      tweet = Tweet.create(
                content: 'Testing DELETE method!',
                user_id: user.id
              )
      comment = Tweet.create(
                content: 'Testing DELETE method! comentario',
                user_id: user.id,
                tweet_id: tweet.id
              )
      like = Like.create(user_id: user.id, tweet_id: comment.id)
      delete :destroy, params: { id: like }
      likes = User.where(id: like.id)
      expect(likes.size).to eq(0)
    end
  end
end