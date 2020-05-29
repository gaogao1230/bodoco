class ProfileTypeChange < ActiveRecord::Migration[5.2]
  
  def up
    change_column :users, :profile, :string
  end
  
  def down
    change_column :users, :profile, :text
  end
end
