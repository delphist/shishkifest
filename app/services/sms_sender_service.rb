class SmsSenderService
  include HTTParty
  base_uri Figaro.env.smsc_api_url

  attr_accessor :message, :phone

  def initialize message:, phone:
    @message = message
    @phone = phone
  end

  def perform
    check_response self.class.get('', query: options)
  end

  private

    def check_response request
      response = JSON.parse(request.body)
      response['cnt'].to_i.positive?
    end

    def options
      {
        login: Figaro.env.smsc_login!,
        psw: Figaro.env.smsc_password!,
        phones: phone,
        mes: message,
        fmt: 3,
        charset: 'utf-8'
      }
    end
end
