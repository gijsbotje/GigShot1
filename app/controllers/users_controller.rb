class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @albums = Album.all.where(:user_id => params[:id]).order("created_at DESC LIMIT 6")
    @pictures = Image.all.where(:user_id => params[:id]).order("created_at DESC LIMIT 6")
  end
end
