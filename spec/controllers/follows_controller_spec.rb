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

    it "returns the created user" do
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
    end
  end
end