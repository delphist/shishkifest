class Member::RejectForm < ApplicationForm
  property :id
  property :message,
    virtual: true,
    default: -> { I18n.t 'sms.member_reject' }
end
