class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :user_id
      t.string :album_title
      t.string :album_desc

      t.timestamps null: false
    end
  end
end
