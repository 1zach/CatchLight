
class PhotosController < ApplicationController

    require 'flickr'
    before_action :set_photos, only: [:show, :edit, :update, :destroy]
 
    def index
        
    end

  def index
        flickr_photos = get_flickr_photos()
        # @photos = flickr_photos
        # This might break the app - if so, reset @photos to Photo.all and we'll add the flickr_photos another way
    @photos = Photo.all + flickr_photos
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


    def get_flickr_photos
        flickr = Flickr.new(ENV["FLICKR_API_KEY"], ENV["FLICKR_SHARED_SECRET"])
        flickr_response = flickr.photos.search(has_geo: 1, lat: 50.846800, lon: 4.352400, geo_context: 2, accuracy: 16, text: "Grand Place")
        flickr_photos = flickr_response.map do |flickr_photo|
            flickr_url = "https://live.staticflickr.com/#{flickr_photo.server}/#{flickr_photo.id}_#{flickr_photo.secret}.jpg"
            Photo.new(url: flickr_url, user: User.find(2))
        end
        flickr_photos
    end


  def photo_params
    params.require(:photo).permit(:url, :creation_date_time, :creator, :location, :focal_length, :camera, :aperture, :lens)
  end
end
