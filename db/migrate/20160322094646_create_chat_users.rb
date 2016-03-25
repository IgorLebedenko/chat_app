class CreateChatUsers < ActiveRecord::Migration
  def change
    create_table :chat_users do |t|
      t.integer :chat_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :chat_users, :chat_id
    add_index :chat_users, :user_id
    add_index :chat_users, [:chat_id, :user_id], unique: true
  end
end
