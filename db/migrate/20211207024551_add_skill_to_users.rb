class AddSkillToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :skill, :integer
  end
end
