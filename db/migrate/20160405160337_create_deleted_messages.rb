class CreateDeletedMessages < ActiveRecord::Migration
  def change
    create_table :deleted_messages do |t|
      t.integer :message_id
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :deleted_messages, :user_id
    add_index :deleted_messages, :message_id
    add_index :deleted_messages, [:message_id, :user_id], unique: true
  end
end
