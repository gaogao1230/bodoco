class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :play_people
      t.string :play_tine
      t.string :content
      t.string :image

      t.timestamps
    end
  end
end
