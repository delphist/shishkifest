class CreateMember < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :name
      t.string :phone
      t.string :license
      t.string :state
      t.text :about
      t.timestamps
    end
  end
end
