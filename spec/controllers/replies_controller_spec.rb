require "rails_helper"
describe RepliesController do 
  describe "GET index" do
    it "returns http status ok" do
     get :index
     expect(response).to have_http_status(:ok)
    end

    it 'render json with all replies' do
      Tweet.create(name: 'Cesar', user_id:1)
      get :index
      tweet = JSON.parse(response.body)
      expect(tweet.size).to eq 1
    end
  end
  describe 'GET show' do
    it 'returns http status ok' do
      tweet= Tweet.create(name: 'Cesar', user_id:1)
      get :show, params: { id: tweet }
      expect(response).to have_http_status(:ok)
    end
    it 'render the correct tweet' do
      tweet = Tweet.create(name: 'Cesar')
      get :show, params: { id: tweet}
      expected_tweet = JSON.parse(response.body)
      expect(expected_tweet["id"]).to eq(tweet.id)
    end
    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

end
