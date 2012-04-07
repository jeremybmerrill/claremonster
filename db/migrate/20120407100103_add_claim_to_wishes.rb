class AddClaimToWishes < ActiveRecord::Migration
  def change
    add_column :wishes, :claimed, :boolean
    add_column :wishes, :claimmsg, :text
  end
end
