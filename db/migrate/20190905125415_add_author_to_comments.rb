class AddAuthorToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :author, foreign_key: true
  end
end
