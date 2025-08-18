class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :keywords
      t.string :genre
      t.string :mood
      t.text :generated_lyrics
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
