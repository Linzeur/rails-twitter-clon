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
      User.create(name: 'Angie',  description: 'Aprendiendo a codear')
      User.create(name: 'Carlos', description: 'Firebase Rules!!')
      User.create(name: 'Cesar',  description: 'BBRRRRR')
      get :index
      users = JSON.parse(response.body)
      expect(users.size).to eq 3
    end
  end

  describe 'GET show' do
    it 'returns http status ok' do
      user = User.create(name: "Deyvi", description: 'Mi pelucaaaaa')
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct user' do
      user = User.create(name: "Deyvi", description: 'Mi segunda prueba')
      get :show, params: { id: user.id }
      expected_user = JSON.parse(response.body)
      expect(expected_user["id"]).to eq(user.id)
    end

    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  # describe "POST create" do
  #   it "returns http status created" do
  #     post :create, params: { model: "OPS768" }
  #     expect(response.status).to eq(201)
  #     expect(response).to have_http_status(:created)
  #   end

  #   it "returns the created airplane" do
  #     post :create, params: { model: "OPS768" }
  #     expected_airplane = JSON.parse(response.body)
  #     expect(expected_airplane).to have_key("id")
  #     expect(expected_airplane["model"]).to eq("OPS768")
  #   end
  # end

  # describe "PATCH update" do
  #   it "returns http status ok" do
  #     airplane = User.create(model: 'OPS768')
  #     patch :update, params: { model: "UIO292", id: User.id, capacity: 100 }
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it "returns the updated airplane" do
  #     airplane = User.create(model: 'OPS768')
  #     patch :update, params: { model: "UIO292", id: User.id, capacity: 50 }
  #     expected_airplane = JSON.parse(response.body)
  #     expect(expected_airplane["model"]).to eq("UIO292")
  #     expect(expected_airplane["capacity"]).to eq(50)
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "returns http status no content" do
  #     airplane = User.create(model: 'OPS768')
  #     delete :destroy, params: { id: airplane }
  #     expect(response).to have_http_status(:no_content)
  #   end

  #   it "returns empty body" do
  #     airplane = User.create(model: 'OPS768')
  #     delete :destroy, params: { id: airplane }
  #     expect(response.body).to eq(" ")
  #   end

  #   it "decrement by 1 the total of airplanes" do
  #     airplane = User.create(model: 'OPS768')
  #     expect do
  #       delete :destroy, params: { id: airplane }
  #     end.to change { User.count }.by(-1)
  #   end

  #   it "actually delete the product" do
  #     airplane = User.create(model: 'OPS768')
  #     delete :destroy, params: { id: airplane }
  #     airplanes = User.where(id: User.id)
  #     expect(airplanes.size).to eq(0)
  #   end
  # end
end