class AddRememberDigestToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :remember_digest, :string
  end
end
