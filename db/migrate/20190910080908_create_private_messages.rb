class CreatePrivateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :private_messages do |t|
      t.text :body
      t.references :conversation, index: true
      t.references :author, index: true
      t.boolean :read, default: false
      t.timestamps
    end
  end
end
