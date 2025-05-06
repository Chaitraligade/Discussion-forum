require 'rails_helper'

require 'swagger_helper'

RSpec.describe 'API::V1::Sessions', type: :request do
  path '/api/v1/sessions' do
    post 'User Login' do
      tags 'User Sessions'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: 'user@example.com' },
          password: { type: :string, example: 'password123' }
        },
        required: ['email', 'password']
      }

      response '200', 'User logged in' do
        let(:credentials) { { email: 'user@example.com', password: 'password123' } }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:credentials) { { email: 'user@example.com', password: 'wrongpassword' } }
        run_test!
      end
    end
  end
end

