class AddAuthorToGossip < ActiveRecord::Migration[5.2]
  def change
    add_reference :gossips, :author, foreign_key: true
  end
end
