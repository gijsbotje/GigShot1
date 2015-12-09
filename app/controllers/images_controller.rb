class ImagesController < ApplicationController
  before_action :find_image, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show, :search]

  def index
    @images = Image.all.order("created_at DESC")
    @banner = Image.order_by_rand.first
    @query = Image.search(params[:search])
  end
  def show

  end
  def new
    @image = current_user.images.build
  end
  def create
    @image = current_user.images.build(image_params)



    if @image.save
      redirect_to @image, notice: "Afbeelding is toegevoegd"
    else
      render 'new'
    end
  end
  def edit

  end
  def update
    if @image.update(pin_params)
      redirect_to @image, notice: "Afbeelding is bijgewerkt"
    else
      render 'edit'
    end
  end
  def destroy
    @image.destroy
    redirect_to root_path
  end
  def upvote
    @image.upvote_by current_user
    redirect_to :back
  end
  private
  def image_params
    params.require(:image).permit(:title, :desc, :image)
  end
  def find_image
    @image = Image.find(params[:id])
  end
end
