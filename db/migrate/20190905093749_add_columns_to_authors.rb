class AddColumnsToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :description, :text
    add_column :authors, :email, :string
    add_column :authors, :age, :integer
  end
end
