# Rswag::Specs.configure do |c|
#   # c.swagger_root = Rails.root.join('swagger').to_s

#   # c.swagger_docs = {
#   #   'v1/swagger.yaml' => {
#   #     openapi: '3.0.1',
#   #     info: {
#   #       title: 'API V1',
#   #       version: 'v1'
#   #     },
#   #     paths: {},
#   #     components: {
#   #       securitySchemes: {
#   #         bearerAuth: {
#   #           type: :http,
#   #           scheme: :bearer,
#   #           bearerFormat: :JWT
#   #         }
#   #       }
#   #     },
#   #     security: [{ bearerAuth: [] }]
#   #   }
#   # }

#   # c.swagger_format = :yaml
# end

Rswag::Api.configure do |c|
  c.openapi_root = Rails.root.to_s + '/swagger'
end
