class SmsHistory < ApplicationRecord
  belongs_to :member
  belongs_to :admin_user

  validates :message, presence: true

  scope :latest, -> { order('created_at DESC') }
end
