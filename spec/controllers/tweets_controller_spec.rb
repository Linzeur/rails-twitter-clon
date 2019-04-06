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


  describe "POST create" do
    it "returns http status created" do
      created_user = User.create(name: "Brayan", description: 'Mis tests!')
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

end

describe "PATCH update" do
  it "returns http status ok" do
    created_user = User.create(name: "Carlos", description: 'Software developer!')
    tweets = Tweet.create(content: "Estoy testeando update!", user: created_user)
    patch :update, params: { user: created_user, id: tweets.id }
    expect(response).to have_http_status(:ok)
  end

#   it "returns the updated product" do
#     product = Product.create(name: 'Apple')
#     patch :update, params: { name: "Orange", id: product.id, category: "Hola" }
#     expected_product = JSON.parse(response.body)
#     expect(expected_product["name"]).to eq("Orange")
#     expect(expected_product["category"]).to eq("Hola")
#   end
# end