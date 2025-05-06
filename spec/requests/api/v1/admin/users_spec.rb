require 'rails_helper'

require 'swagger_helper'

RSpec.describe 'API::V1::Admin::Users', type: :request do
  path '/api/v1/admin/users' do
    get 'Retrieve all admin users' do
      tags 'Admin Users'
      security [bearerAuth: []]
      produces 'application/json'

      response '200', 'Admin users retrieved' do
        let(:Authorization) { "Bearer valid_jwt_token" }
        run_test!
      end
    end
  end
end
