class AlbumsController < ApplicationController
  before_action :find_album, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show, :search]

  def index
    @albums = Album.all.where(:user_id => current_user).order("created_at DESC LIMIT 6")
  end

  def show
    @album  = find_album
    @pictures = @album.images
  end

  def new
    @album = current_user.albums.build
    @image = current_user.images.build
  end

  def create
    @album = current_user.albums.create(album_params)

      if @album.save

        if params[:images]
          params[:images].each do |img|
            @image = current_user.images.create(image: img, :album_id => @album.id, title: img.original_filename)
          end
            redirect_to @album, notice: "Album aangemaakt met alle afbeeldingen"
        else
          render 'new', notice: "Er is iets fout gegaan, probeer het opnieuw"
        end
      end
  end

  def edit
    if @album.user != current_user
      redirect_to album_path, notice: "U heeft geen rechten om dit album te bewerken."
    end
  end
  def update
    if @album.update(album_params)
      redirect_to @album, notice: "Afbeelding is bijgewerkt"
    else
      render 'edit'
    end
  end
  def destroy
    if @album.user != current_user
      redirect_to album_path, notice: "U heeft geen rechten om dit album te verwijderen."
    else
      @album.destroy
      @pictures = @album.images
      @pictures.each do |pic|
        pic.destroy
      end
      redirect_to root_path, notice: "Het album is succesvol verwijderd."
    end
  end

  private

    def album_params
      params.require(:album).permit(:user_id, :album_desc, :album_title, :images)
    end

    def find_album
      @album = Album.find(params[:id])
    end
end
