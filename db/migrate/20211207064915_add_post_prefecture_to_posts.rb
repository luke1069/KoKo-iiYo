class AddPostPrefectureToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :post_prefecture, :integer, default: 0
  end
end
