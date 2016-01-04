class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|

      t.integer :user_id
      t.integer :album_id
      t.integer :show_id
      t.integer :band_id
      t.text :title
      t.text :desc
      t.datetime :picDate
      t.string :likes
      t.text :tags
      t.string :eShutter
      t.string :eAperture
      t.string :eFocal
      t.string :eIso
      t.string :Eflash
      t.string :eCamModel
      t.string :eCamLens


      t.timestamps null: false
    end
  end
end
