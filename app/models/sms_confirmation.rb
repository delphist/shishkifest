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
  validates :token, :code, :phone, presence: true
  validates :token, uniqueness: true
end
