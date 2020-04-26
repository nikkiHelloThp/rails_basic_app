class AddIndexCreatedAtToGossips < ActiveRecord::Migration[5.2]
  def change
  	add_index :gossips, [:author_id, :created_at]
  end
end
