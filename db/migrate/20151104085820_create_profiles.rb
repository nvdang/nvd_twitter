class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.date :birthday
      t.string :sex
      t.string :tel
      t.string :address
      t.attachment :avatar

      t.timestamps null: false
    end
  end
end
