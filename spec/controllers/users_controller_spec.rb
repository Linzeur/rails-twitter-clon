require 'rails_helper'

describe UsersController do
  before do
    User.delete_all
  end

  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'render json with all users' do
      User.create(
        name: 'Angie',
        username: 'AngieC',
        description: 'Aprendiendo a codear'
      )
      User.create(
        name: 'Carlos',
        username: 'CarlitosS',
        description: 'Firebase Rules!!'
      )
      get :index
      users = JSON.parse(response.body)
      expect(users.size).to eq 2
    end
  end

  describe 'GET show' do
    it 'returns http status ok' do
      user = User.create(
              name: "Deyvi",
              username: 'deyconde',
              description: 'Mi pelucaaaaa'
            )
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct user' do
      user = User.create(
              name: "Deyvi",
              username: 'deyconde',
              description: 'Mi segunda prueba'
            )
      get :show, params: { id: user.id }
      expected_user = JSON.parse(response.body)
      expect(expected_user["id"]).to eq(user.id)
    end

    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST create" do
    it "returns http status created" do
      post :create, params: { name: "Usuario 1", username: "userTest", country: "Peru" }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it "returns the created user" do
      post :create, params: { name: "Usuario 1", username: "userTest", country: "Peru" }
      expected_user = JSON.parse(response.body)
      expect(expected_user).to have_key("id")
      expect(expected_user["name"]).to eq("Usuario 1")
    end
  end

  describe "PATCH update" do
    it "returns http status ok" do
      user = User.create(
              name: "Usuario 1",
              username: "userTest",
              description: "Soy un nuevo usuario de prueba",
              country: "Peru"
            )
      patch :update, params: { id: user.id, name: "Usuario 1 updated", username: "userTest1" }
      expect(response).to have_http_status(:ok)
    end

    it "returns the updated user" do
      user = User.create(
              name: "Usuario 1",
              username: "userTest",
              description: "Soy un nuevo usuario de prueba",
              country: "Peru"
            )
      patch :update, params: { id: user.id, name: "Usuario 1 updated", username: "userTest1" }
      expected_user = JSON.parse(response.body)
      expect(expected_user["name"]).to eq("Usuario 1 updated")
      expect(expected_user["username"]).to eq("userTest1")
    end
  end

  describe "DELETE destroy" do
    it "returns http status no content" do
      user = User.create(
              name: "Usuario 2",
              username: "test456",
              description: "Soy otro nuevo usuario de prueba para twitter",
              country: "Bolivia",
              url: "http://www.twitter.com/usu2.456"
            )
      delete :destroy, params: { id: user }
      expect(response).to have_http_status(:no_content)
    end

    it "returns empty body" do
      user = User.create(
              name: "Usuario 2",
              username: "test456",
              description: "Soy otro nuevo usuario de prueba para twitter",
              country: "Bolivia",
              url: "http://www.twitter.com/usu2.456"
            )
      delete :destroy, params: { id: user }
      expect(response.body).to eq(" ")
    end

    it "decrement by 1 the total of users" do
      user = User.create(
              name: "Usuario 2",
              username: "test456",
              description: "Soy otro nuevo usuario de prueba para twitter",
              country: "Bolivia",
              url: "http://www.twitter.com/usu2.456"
            )
      expect do
        delete :destroy, params: { id: user }
      end.to change { User.count }.by(-1)
    end

    it "actually delete the user" do
      user = User.create(
              name: "Usuario 2",
              username: "test456",
              description: "Soy otro nuevo usuario de prueba para twitter",
              country: "Bolivia",
              url: "http://www.twitter.com/usu2.456"
            )
      delete :destroy, params: { id: user }
      users = User.where(id: user.id)
      expect(users.size).to eq(0)
    end
  end
end