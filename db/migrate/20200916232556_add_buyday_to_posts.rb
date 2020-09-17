class AddBuydayToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :buyday, :datetime
  end
end
