class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :likes, :string
    add_column :users, :phonenumber, :string
  end
end
