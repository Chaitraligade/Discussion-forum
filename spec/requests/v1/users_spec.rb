require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  before do
    # Manually create a user in the database
    @user = User.create!(
      username: "John Doe",  # ✅ Comma added here
      email: "john.doe@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    # Generate a JWT token for authentication
    @auth_token = JsonWebToken.encode(user_id: @user.id)

    # Mock JWT decoding to always return the user ID
    allow(JsonWebToken).to receive(:decode).and_return({ 'user_id' => @user.id })
  end

  describe "GET /api/v1/users" do
    it "returns a list of users" do
      get "/api/v1/users", headers: { "Authorization": "Bearer #{@auth_token}" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to be_an(Array) # Ensure response is an array
    end
  end
end
