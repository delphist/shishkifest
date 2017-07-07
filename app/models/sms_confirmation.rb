# == Schema Information
#
# Table name: sms_confirmations
#
#  id         :integer          not null, primary key
#  token      :string
#  phone      :string
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SmsConfirmation < ApplicationRecord
  phony_normalize :phone, country_code: 'RU'

  validates :token, :code, :phone, presence: true
  validates :token, uniqueness: true
end
