class CreateSmsConfirmation < ActiveRecord::Migration[5.1]
  def change
    create_table :sms_confirmations do |t|
      t.string :token, unique: true
      t.string :phone
      t.string :code
      t.timestamps
    end
  end
end
