class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.integer :followers
      t.integer :popularity
      t.string :spotifyId
      t.string :picture

      t.timestamps
    end
  end
end
