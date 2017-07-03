require 'grape-swagger'

class ApplicationAPI < Grape::API
  format :json
  cascade true

  mount Api::Photos
  mount Api::SmsConfirmations
  mount Api::Members

  add_swagger_documentation
end
