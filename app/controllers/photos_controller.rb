class PhotosController < ApplicationController
  before_action :set_photos, only: [:show, :edit, :update, :destroy]



  def index
   if params[:location].present? # && params[:creation_date_time].present?
    #change the location into longitude and lattitude
    #add a range of closeness to the longitude and lattitude
    #add the creation_date_time as a parameter
    #
    @photos = Photo.where("location ILIKE ? AND creation_date_time ILIKE ?", "#{params[:location]}, ""#{params[:creation_date_time]}")
   else
    @photos = Photo.all
    end
    # The `geocoded` scope filters only flats with coordinates
    @markers = @photos.geocoded.map do |photo|
      {
        lat: photo.latitude,
        lng: photo.longitude
      }
      end
  end

  def show
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user
    if @photo.save
      redirect_to photo_path(@photo)
    else
    render:new, status: :unprocessable_entity
    end
end

  def edit
  end

  def update
    @photo.update(photo_params)
    redirect_to photo_path(@photo)
  end

  def destroy
    @photo.destroy
    redirect_to photos_path, status: :see_other
  end

  private

  def set_photos
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:url, :creation_date_time, :creator, :location, :focal_length, :camera, :aperture, :lens)
  end
end
