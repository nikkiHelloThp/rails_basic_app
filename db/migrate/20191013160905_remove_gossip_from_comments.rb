class RemoveGossipFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_reference :comments, :gossip, foreign_key: true
  end
end
