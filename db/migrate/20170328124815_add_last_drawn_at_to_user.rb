class AddLastDrawnAtToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :last_drawn_at, :datetime
  end
end
