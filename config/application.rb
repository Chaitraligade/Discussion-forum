require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require "sassc"

module ForumApp
  class Application < Rails::Application
    config.swagger_docs = {
      'v1/swagger.yaml' => {
        openapi: '3.0.1',
        info: {
          title: 'API V1',
          version: 'v1'
        },
        paths: {},
        components: {
          securitySchemes: {
            bearerAuth: {
              type: :http,
              scheme: :bearer,
              bearerFormat: :JWT
            }
          }
        },
        security: [{ bearerAuth: [] }]
      }
    }
  end
end
