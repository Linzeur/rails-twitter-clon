require 'rails_helper'

describe FollowsController do
  before do
    Follow.delete_all
  end

  describe "POST create" do
    it "returns http status created" do
      first_user = User.create(
                    name: 'Angie',
                    username: 'AngieC',
                    description: 'Aprendiendo a codear'
                  )
      second_user = User.create(
                      name: 'Carlos',
                      username: 'CarlitosS',
                      description: 'Firebase Rules!!'
                    )
      post :create, params: { user_id: second_user.id, followed_id: first_user.id }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it "returns the created follow" do
      first_user = User.create(
        name: 'Angie',
        username: 'AngieC',
        description: 'Aprendiendo a codear'
      )
      second_user = User.create(
                name: 'Carlos',
                username: 'CarlitosS',
                description: 'Firebase Rules!!'
              )
      post :create, params: { user_id: second_user.id, followed_id: first_user.id }
      expected_user = JSON.parse(response.body)
      expect(expected_user).to have_key("id")
      expect(expected_user["follower_id"]).to eq(second_user.id)
      expect(expected_user["followed_id"]).to eq(first_user.id)
    end
  end

  describe "DELETE destroy" do
    it "returns http status no content" do
      first_user = User.create(
                    name: 'Angie',
                    username: 'AngieC',
                    description: 'Aprendiendo a codear'
                  )
      second_user = User.create(
                      name: 'Carlos',
                      username: 'CarlitosS',
                      description: 'Firebase Rules!!'
                    )
      follow = Follow.create(follower_id: first_user.id, followed_id: second_user.id)
      delete :destroy, params: { user_id:first_user.id, id: follow.id }
      expect(response).to have_http_status(:no_content)
    end

    it "returns empty body" do
      first_user = User.create(
                    name: "Usuario 2",
                    username: "test456",
                    description: "Soy otro nuevo usuario de prueba para twitter",
                    country: "Bolivia",
                    url: "http://www.twitter.com/usu2.456"
                  )
      second_user = User.create(
                      name: "Usuario 1",
                      username: "userTest",
                      description: "Soy un nuevo usuario de prueba",
                      country: "Peru"
                    )
      follow = Follow.create(follower_id: first_user.id, followed_id: second_user.id)
      delete :destroy, params: { user_id:first_user.id, id: follow }
      expect(response.body).to eq(" ")
    end

    it "decrement by 1 the total of follows" do
      first_user = User.create(
                    name: "Usuario 2",
                    username: "test456",
                    description: "Soy otro nuevo usuario de prueba para twitter",
                    country: "Bolivia",
                    url: "http://www.twitter.com/usu2.456"
                  )
      second_user = User.create(
                      name: "Deyvi",
                      username: 'deyconde',
                      description: 'Mi segunda prueba'
                    )
      follow = Follow.create(follower_id: first_user.id, followed_id: second_user.id)
      expect do
        delete :destroy, params: { user_id:first_user.id, id: follow }
      end.to change { Follow.count }.by(-1)
    end

    it "actually delete the follow" do
      first_user = User.create(
                    name: "Usuario 2",
                    username: "test456",
                    description: "Soy otro nuevo usuario de prueba para twitter",
                    country: "Bolivia",
                    url: "http://www.twitter.com/usu2.456"
                  )
      second_user = User.create(
                      name: "Deyvi",
                      username: 'deyconde',
                      description: 'Mi segunda prueba'
                    )
      follow = Follow.create(follower_id: first_user.id, followed_id: second_user.id)
      delete :destroy, params: { user_id:first_user.id, id: follow }
      follows = User.where(id: follow.id)
      expect(follows.size).to eq(0)
    end
  end
end