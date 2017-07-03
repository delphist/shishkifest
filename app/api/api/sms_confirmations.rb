class Api::SmsConfirmations < Grape::API
  namespace :sms_confirmations do
    desc 'Sms confirmations', entity: Entities::SmsConfirmation
    params do
      requires :phone, type: String
    end
    post do
      present SmsConfirmationService.new(params[:phone]).perform,
        with: Entities::SmsConfirmation
    end
  end
end
