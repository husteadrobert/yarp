class ChangePhonenumberToString < ActiveRecord::Migration[5.1]
  def change
    change_column :businesses, :phone_number, :string
  end
end
