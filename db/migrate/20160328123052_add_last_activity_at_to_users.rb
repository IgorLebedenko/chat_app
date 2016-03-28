class AddLastActivityAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_activity_at, :datetime, null: false, default: Time.now
  end
end
