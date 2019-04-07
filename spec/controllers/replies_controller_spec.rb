require "rails_helper"
describe RepliesController do 

  before do
    Tweet.delete_all
  end

  describe "PATCH update" do
    it "returns http status ok" do
      created_user = User.create(
        name: "Carlos", 
        description: 'Software developer!'
      )
      tweets = Tweet.create(
      content: "Estoy testeando update!", 
      user_id: created_user.id
      )
      tweet_replies = Tweet.create(
        tweet_id: tweets.id,
        content: "Respondiendo a mi tweet",
        user_id: created_user.id
      )
      patch :update, params: {content: "Quiero actualizar mi tweet", id: tweet_replies.id}
      expect(response).to have_http_status(:ok)
    end

    it "returns the updated product" do
      created_user = User.create(
        name: "Carlos", 
        description: 'Software developer!'
      )
      new_user = User.create(
        name: "Cesar", 
        description: 'Full Stack Software developer!'
      )
      tweets = Tweet.create(
      content: "Estoy testeando update!", 
      user_id: created_user.id
      )
      tweet_replies = Tweet.create(
        tweet_id: tweets.id,
        content: "Respondiendo a un tweet",
        user_id: new_user.id
      )
      patch :update, params: { content: "Estoy testeando replies", id: tweet_replies.id }
      expected_product = JSON.parse(response.body)
      expect(expected_product["content"]).to eq("Estoy testeando replies")     
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
      tweet_replies = Tweet.create(
        tweet_id: tweets.id,
        content: "Respondiendo a un tweet",s
        user_id: created_user.id
      )      
      delete :destroy, params: { id: tweet_replies.id }
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
      tweet_replies = Tweet.create(
        tweet_id: tweets.id,
        content: "Respondiendo a un tweet",
        user_id: created_user.id
      ) 
      delete :destroy, params: { id: tweet_replies.id }
      expect(response.body).to eq(" ")
    end

    it "actually delete the reply" do
      created_user = User.create(
                      name: "Sergio", 
                      description: 'Full Stack Software Developer!'
                      )
      created_tweet = Tweet.create(
                      content: "Esto será destruido", 
                      user_id: created_user.id
                      )
      tweet_replies = Tweet.create(
                      tweet_id: created_tweet,
                      content: "Respondiendo a un tweet",
                      user_id: created_user.id
      ) 
      tweets = Tweet.where(tweet_id: created_tweet.id)
      delete :destroy, params: { id: tweet_replies.id }
      expect(tweets.size).to eq(0)
    end

  end
  

end
