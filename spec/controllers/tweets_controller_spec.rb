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
                  description: 'Aprendiendo a codear'
                  )
      tweet = Tweet.create(
                  content: 'Testeando tweets!', 
                  user: usuario
                  )
      p tweet.errors
      get :index
      tweets = JSON.parse(response.body)
      expect(tweets.size).to eq(1)
    end
  end

  describe 'GET show' do
    it 'returns http status ok' do
      created_user = User.create(name: "Deyvi", description: 'Mi pelucaaaaa')
      tweets = Tweet.create(
              content: 'Estoy testeando show!',
              user: created_user
              )
            get :show, params: { id: tweets.id }
      expect(response).to have_http_status(:ok)
    end
  end


    it 'render the correct tweet' do
      created_user = User.create(name: "Deyvi", description: 'Mi pelucaaaaa')
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