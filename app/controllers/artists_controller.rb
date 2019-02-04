class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :new, alert: "Fail to create"
    end
  end

  def edit
    if params[:id] && !Artist.exists?(params[:id])
      redirect_to artists_path, alert: "Artist not found"
    else
      @artist = Artist.find(params[:id])
    end
  end

  def update
    if params[:id] && !Artist.exists?(params[:id])
      redirect_to artists_path, alert: "Artist not found"
    else
      @artist = Artist.find(params[:id])

      @artist.update(artist_params)

      if @artist.save
        redirect_to @artist
      else
        render :edit
      end
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end