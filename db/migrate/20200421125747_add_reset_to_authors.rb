class AddResetToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :reset_digest, :string
    add_column :authors, :reset_sent_at, :datetime
  end
end
