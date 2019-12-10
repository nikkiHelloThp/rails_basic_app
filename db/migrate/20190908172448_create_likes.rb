class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
    	t.references :author, index: true
    	t.references :gossip, index: true
      t.timestamps
    end
  end
end
