class CreateSmsHistory < ActiveRecord::Migration[5.1]
  def change
    create_table :sms_histories do |t|
      t.references :admin_user, foreign_key: true
      t.references :member, foreign_key: true
      t.text :message
      t.timestamps
    end
  end
end
