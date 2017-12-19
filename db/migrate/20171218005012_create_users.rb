class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.timestamps
      t.string :email
      t.string :password_digest
    end
  end
end
