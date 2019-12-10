class AddPasswordToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :password_digest, :string
  end
end
