# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  name       :string
#  phone      :string
#  license    :string
#  state      :string
#  about      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Member < ApplicationRecord
  include AASM

  has_many :photos
  phony_normalize :phone, default_country_code: 'RU'

  aasm column: 'state' do
    state :created, initial: true
  end
end
