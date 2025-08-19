class AddMusicStyleAndMusicianTypeToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :music_style, :string
    add_column :users, :musician_type, :string
  end
end
