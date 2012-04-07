class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.references :wish
      t.references :user

      t.timestamps
    end

    add_index :comments, :wish_id
  end
end
