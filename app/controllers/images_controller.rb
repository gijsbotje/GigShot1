class ImagesController < ApplicationController
  before_action :find_image, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show, :search]

  def index
    @images = Image.all.order("created_at DESC LIMIT 12")
    @banner = Image.order_by_rand.first
    @query = Image.search(params[:search])
    searchparams
  end
  def show
    find_image
  end
  def new
    @image = current_user.images.build
  end
  def create
    if params[:images]
      params[:images].each do |img|
        @image = current_user.images.create(image: img, title: img.original_filename)
      end
      if @image.save
        redirect_to @image, notice: "Afbeelding is toegevoegd"
      end
    else
      render 'new', notice: "Er is iets fout gegaan, probeer het opnieuw"
    end
  end
  def edit
    if @image.user != current_user
      redirect_to image_path, notice: "U heeft geen rechten om deze afbeelding te bewerken."
    end
  end
  def update
    if @image.update(image_params)
      redirect_to @image, notice: "Afbeelding is bijgewerkt"
    else
      render 'edit'
    end
  end
  def destroy
    if @image.user != current_user
      redirect_to @image, notice: "U heeft geen rechten om deze afbeelding te verwijderen."
    else
      @image.destroy
      redirect_to root_path, notice: "afbeelding #{@image.title} is verwijderd."
    end
  end
  def upvote
    @image.upvote_by current_user
    redirect_to :back
  end
  def downvote
    @image.downvote_by current_user
    redirect_to :back
  end
  private
  def image_params
    params.require(:image).permit(:user_id, :title, :desc, :image)
  end
  def find_image
    @image = Image.find(params[:id])
  end
  def searchparams
    @search = params[:search].to_s
    @params = '%'+ @search +'%'
    @users = User.all.where("username LIKE ?", @params).order("created_at DESC LIMIT 12")
    @albums = Album.all.where("album_title LIKE ?", @params).order("created_at DESC LIMIT 3")
  end
end
