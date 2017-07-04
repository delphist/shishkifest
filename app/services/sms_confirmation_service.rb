class SmsConfirmationService
  attr_reader :phone, :model

  def initialize phone
    @model = nil
    @phone = phone
    @token = nil
    @code = nil
  end

  def perform
    create_model
    send_sms
    model
  end

  def token
    @token ||= generate_token
  end

  def code
    @code ||= generate_code
  end

  private

    def send_sms
      SmsSenderService.new(
        phone: phone,
        message: I18n.t('user_sms_confirmation', code: code)
      ).perform
    end

    def create_model
      @model = SmsConfirmation.create!(
        phone: phone,
        token: token,
        code: code
      )
    end

    def generate_token
      begin
        token = Digest::MD5.hexdigest "#{phone}_#{code}_#{Time.zone.now.to_s}"
      end while SmsConfirmation.exists? token: token
      token
    end

    def generate_code
      [1, 1, 1, 1].map! { |x| (0..9).to_a.sample }.join
    end
end
