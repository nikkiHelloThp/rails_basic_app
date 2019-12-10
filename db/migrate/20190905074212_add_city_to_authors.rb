class AddCityToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_reference :authors, :city, foreign_key: true
  end
end
