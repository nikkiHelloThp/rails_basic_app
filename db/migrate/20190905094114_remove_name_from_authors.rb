class RemoveNameFromAuthors < ActiveRecord::Migration[5.2]
  def change
    remove_column :authors, :name, :string
  end
end
