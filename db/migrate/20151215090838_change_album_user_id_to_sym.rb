class ChangeAlbumUserIdToSym < ActiveRecord::Migration
  def up
   change_column :albums, :user_id, :integer
  end

  def down
   change_column :albums, :user_id, :string
  end
end
