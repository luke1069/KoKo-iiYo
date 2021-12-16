class AddDetails2ToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :lat, :float
    add_column :posts, :lng, :float
  end
end
