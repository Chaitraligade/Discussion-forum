require 'swagger_helper'

RSpec.describe 'api/v1/discussion_threads', type: :request do
  path '/api/v1/users/{user_id}/discussion_threads' do
    get 'List discussion threads' do
      tags 'Discussion Threads'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer

      response '200', 'Threads listed successfully' do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            body: { type: :string },
            created_at: { type: :string }
          },
          required: ['id', 'title', 'body', 'created_at']
        }
        run_test!
      end
    end

    post 'Create a discussion thread' do
      tags 'Discussion Threads'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :thread, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          body: { type: :string }
        },
        required: ['title', 'body']
      }

      response '201', 'Thread created successfully' do
        run_test!
      end

      response '422', 'Invalid request' do
        run_test!
      end
    end
  end
end
