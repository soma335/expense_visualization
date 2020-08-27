class AddStatusToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :status, :integer, default: 1, null: false, limit: 1
  end
end
