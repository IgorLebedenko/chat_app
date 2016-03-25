class AddPrivateToChats < ActiveRecord::Migration
  def change
    add_column :chats, :private, :boolean, default: false
  end
end
