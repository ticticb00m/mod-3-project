class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :songList
      t.string :picture
      t.string :spotifyId

      t.timestamps
    end
  end
end
