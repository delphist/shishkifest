class Member::StatusService
  attr_reader :form, :model, :hash, :status

  def initialize form, admin_user, status
    @form = form
    @admin_user = admin_user
    @status = status
    @model = nil
    @hash = nil
  end

  def perform
    Member.transaction do
      @form.save do |hash|
        @model = form.model
        @hash = hash
        set_status
        send_notification
      end
    end
  end

  private

    def set_status
      case status
      when :approve
        @model.approve!
      when :reject
        @model.reject!
      end
    end

    def send_notification
      SmsSenderService.new(
        phone: model.phone,
        message: form.message
      ).perform
      SmsHistory.create!(
        member: model,
        admin_user: @admin_user,
        message: form.message
      )
    end
end
