class CreateNotifyUserNotifications < ActiveRecord::Migration[4.2]
  def change
    create_table :notify_user_notifications do |t|
      t.string :type
      t.json :params
      t.datetime :read_at

      t.integer :target_id
      t.string :target_type
      t.integer :group_id
      t.integer :parent_id

      t.timestamps
    end

    add_index :notify_user_notifications, :group_id
    add_index :notify_user_notifications, :parent_id
    add_index :notify_user_notifications, :target_id
    add_index :notify_user_notifications, :created_at
    add_index :notify_user_notifications, :read_at
  end
end
