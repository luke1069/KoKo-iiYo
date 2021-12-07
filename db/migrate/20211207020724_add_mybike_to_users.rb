class AddMybikeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mybike, :string
  end
end
