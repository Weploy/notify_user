class CreateNotifyUserDeliveries < ActiveRecord::Migration[4.2]
  def change
    create_table :notify_user_deliveries do |t|
      t.datetime :sent_at
      t.string :channel
      t.integer :deliver_in
      t.json :responses

      t.integer :notification_id

      t.timestamps
    end

    add_index :notify_user_deliveries, :notification_id
    add_index :notify_user_deliveries, :sent_at
  end
end
