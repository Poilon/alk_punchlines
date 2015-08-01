class CreateSong < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.text :lyrics
      t.integer :artist_id
    end
  end
end
