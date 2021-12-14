require 'rails_helper'

RSpec.describe "login route test", type: :request do

  before do
   @password = "pass_test1"
   @user = User.new(username: "test122", email: "test@example.com", password_digest: BCrypt::Password.create(@password), user_type: 2)
   @user.save
  end

  it "login route with correct creds" do
    post "/users/login", params: {username: @user.username, password: @password}, headers: { Accept: "application/json" }

    resp_json = ActiveSupport::JSON.decode(response.body)["user"]
    expect(response.status).to eq(200)
    expect(resp_json["username"]).to eq(@user.username)
    expect(resp_json["email"]).to eq(@user.email)
    expect(resp_json["type"]).to eq(@user.user_type)
    expect(response).to render_template(:login)
  end

  it "login route with incorrect creds" do
   post "/users/login", params: {username: @user.username, password: "aaa"}, headers: { Accept: "application/json" }

    resp_json = ActiveSupport::JSON.decode(response.body)
    expect(response.status).to eq(401)
    expect(resp_json["success"]).to eq(false)
   end
end

RSpec.describe "me route test", type: :request do

  before do
   @password = "pass_test1"
   @user = User.new(username: "test122", email: "test@example.com", password_digest: BCrypt::Password.create(@password), user_type: 1)
   @user.save
  end

  it "test me route" do
    # login for token
    post "/users/login", params: {username: @user.username, password: @password}, headers: { Accept: "application/json" }
    token = ActiveSupport::JSON.decode(response.body)["jwt"]["token"]

    # request to /users/me
    get "/users/me", headers: { Authorization: "Bearer #{token}", Accept: "application/json" }
    resp_json = ActiveSupport::JSON.decode(response.body)["user"]
    expect(response.status).to eq(200)
    expect(resp_json["username"]).to eq(@user.username)
    expect(resp_json["email"]).to eq(@user.email)
    expect(resp_json["type"]).to eq(@user.user_type)
    expect(response).to render_template(:me)
  end

end
