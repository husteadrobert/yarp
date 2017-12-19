class CreateBusinesses < ActiveRecord::Migration[5.1]
  def change
    create_table :businesses do |t|
      t.timestamps
      t.string :name
      t.string :address
      t.integer :phone_number
    end
  end
end
