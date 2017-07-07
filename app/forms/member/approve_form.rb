class Member::ApproveForm < ApplicationForm
  property :id
  property :message,
    virtual: true,
    default: -> { I18n.t 'sms.member_approve' }
end
