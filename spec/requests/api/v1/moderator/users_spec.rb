require 'rails_helper'

require 'swagger_helper'

RSpec.describe 'API::V1::Moderator::Users', type: :request do
  path '/api/v1/moderator/users' do
    get 'Retrieve all moderator users' do
      tags 'Moderator Users'
      security [bearerAuth: []] # Requires JWT token
      produces 'application/json'

      response '200', 'Moderator users retrieved' do
        let(:Authorization) { "Bearer valid_jwt_token" }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { nil }
        run_test!
      end
    end
  end
end
