class RenamePlayTineColumnToGames < ActiveRecord::Migration[5.2]
  def change
    rename_column :games, :play_tine, :play_time
  end
end
