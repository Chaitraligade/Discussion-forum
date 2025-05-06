require 'swagger_helper'

RSpec.describe 'API::V1::Users', type: :request do
  path '/api/v1/users/profile' do
    get 'Fetch user profile' do
      tags 'Users'
      security [bearerAuth: []]
      response '200', 'User profile retrieved successfully' do
        run_test!
      end
    end
  end

  path '/api/v1/users/update' do
    put 'Update user details' do
      tags 'Users'
      security [bearerAuth: []]
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          phone: { type: :string }
        },
        required: %w[name email]
      }

      response '200', 'User updated successfully' do
        run_test!
      end
    end
  end

  path '/api/v1/users/change_password' do
    put 'Change user password' do
      tags 'Users'
      security [bearerAuth: []]
      consumes 'application/json'
      parameter name: :passwords, in: :body, schema: {
        type: :object,
        properties: {
          current_password: { type: :string },
          new_password: { type: :string }
        },
        required: %w[current_password new_password]
      }

      response '200', 'Password changed successfully' do
        run_test!
      end
    end
  end
end

