class ChangeNotidicationsToNotifications < ActiveRecord::Migration[5.2]
  def change
    rename_table :notidications, :notifications
  end
end
