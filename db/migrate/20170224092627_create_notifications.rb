class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
    	t.boolean :seen, default: false
    	t.string :notification_text
    	t.belongs_to :user
    	t.timestamps
    end
  end
end