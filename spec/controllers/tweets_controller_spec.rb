require 'rails_helper'

describe TweetsController do
  before do
    Tweet.delete_all
  end

  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'render json with all tweets' do

      usuario = User.create(
                  name: 'Angie',
                  username: 'AngieC',
                  description: 'Aprendiendo a codear'
                )
      tweet = Tweet.create(
                content: 'Testeando tweets!', 
                user: usuario
              )
      get :index
      tweets = JSON.parse(response.body)
      expect(tweets.size).to eq(1)
    end
  end



  describe 'GET show' do
    it 'returns http status ok' do
      created_user = User.create(
                      name: "Deyvi",
                      username: 'deyconde',
                      description: 'Mi pelucaaaaa'
                    )
      tweets = Tweet.create(
                content: 'Estoy testeando show!',
                user: created_user
              )
            get :show, params: { id: tweets.id }
      expect(response).to have_http_status(:ok)
    end


    it 'render the correct tweet' do
      created_user = User.create(
                      name: "Deyvi",
                      username: 'deyconde',
                      description: 'Mi pelucaaaaa'
                    )
      tweets = Tweet.create(
                content: "Estoy mostrando el correcto tweet", 
                user: created_user
              )
      get :show, params: { id: tweets.id }
      expected_tweet = JSON.parse(response.body)
      expect(expected_tweet["id"]).to eq(tweets.id)
    end

    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end


  describe "POST create" do
    it "returns http status created" do
      created_user = User.create(
                      name: "Brayan",
                      username: 'linzeur',
                      description: 'Mis tests!'
                    )
      post :create, params: { content: "Este tweet ha sido creado!", user: created_user}
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it "returns the created tweet" do
      post :create, params: { content: "Este tweet se debe mostrar" }
      expected_tweet = JSON.parse(response.body)
      expect(expected_tweet).to have_key("id")
      expect(expected_tweet["content"]).to eq("Este tweet se debe mostrar")
    end
  end  


  describe "PATCH update" do
    it "returns http status ok" do
      created_user = User.create(
                      name: "Carlos",
                      username: 'calitosS',
                      description: 'Software developer!'
                    )
      tweets = Tweet.create(content: "Estoy testeando update!", user_id: created_user.id)
      patch :update, params: { id: tweets.id}
      expect(response).to have_http_status(:ok)
    end

    it "returns the updated product" do
      created_user = User.create(
                      name: "Carlos",
                      username: 'calitosS',
                      description: 'Software developer!'
                    )
      tweets = Tweet.create(content: "Estoy testeando update!", user_id: created_user.id)
      patch :update, params: {  id: tweets.id, content: "Updated!" }
      expected_tweet = JSON.parse(response.body)
      expect(expected_tweet["content"]).to eq("Updated!")
    end
  end


  describe "DELETE destroy" do
    it "returns http status no content" do
      created_user = User.create(
                      name: "Cesar", 
                      description: 'Ruby developer!'
                      )
      tweets = Tweet.create(
                content: 'Testing DELETE method!', 
                user_id: created_user.id
                )
      delete :destroy, params: { id: tweets.id }
      expect(response).to have_http_status(:no_content)
    end

    it "returns empty body" do
      created_user = User.create(
                      name: "Angie", 
                      description: 'Developing my twitter API!'
                      )
      tweets = Tweet.create(
                content: 'Testeando el método destroy', 
                user_id: created_user.id
                )
      delete :destroy, params: { id: tweets.id }
      expect(response.body).to eq(" ")
    end

    it "actually delete the Tweet" do
      created_user = User.create(
                      name: "Sergio", 
                      description: 'Full Stack Software Developer!'
                      )
      created_tweet = Tweet.create(
                      content: "Esto será destruido", 
                      user_id: created_user.id
                      )
      tweets = Tweet.where(user_id: created_user.id)
      delete :destroy, params: { id: created_tweet.id }
      expect(tweets.size).to eq(0)
    end
  end
end