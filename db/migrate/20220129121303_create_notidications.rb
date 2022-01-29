class CreateNotidications < ActiveRecord::Migration[5.2]
  def change
    create_table :notidications do |t|
      t.integer :visitor_id, null: false
      t.integer :visted_id, null: false
      t.integer :post_id
      t.integer :comment_id
      t.integer :room_id
      t.integer :message_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :notidications, :visitor_id
    add_index :notidications, :visted_id
    add_index :notidications, :post_id
    add_index :notidications, :comment_id
    add_index :notidications, :room_id
    add_index :notidications, :message_id
  end
end
