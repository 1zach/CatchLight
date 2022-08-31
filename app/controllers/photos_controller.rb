
class PhotosController < ApplicationController

    require 'flickr'
    skip_before_action :authenticate_user!, only: [:index, :show]

    before_action :set_photos, only: [:show, :edit, :update, :destroy]

  def index
        flickr_photos = get_flickr_photos()
        @photo = get_flickr_photo()
        # @photos = flickr_photos
        # This might break the app - if so, reset @photos to Photo.all and we'll add the flickr_photos another way
        @photos = flickr_photos
        # The `geocoded` scope filters only photos with coordinates
        #@markers = @photos.geocoded.map do |photo|
        #   
        #  {
        #      
        #    lat: photo.latitude,
        #    lng: photo.longitude
        #  }
        #end

    @markers = flickr_photos.map do |photo|
        {
            lat: photo.latitude,
            lng: photo.longitude,
            url: photo.url,
            info_window: render_to_string(partial: "info_window", locals: {photo: photo})
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
    @photo.creator = current_user.first_name
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
        flickr_response = flickr.photos.search(
            has_geo: 1, 
            lat: 50.846800, 
            lon: 4.352400, 
            geo_context: 2, 
            accuracy: 16, 
            text: "graffiti", 
            extras: "geo, date_taken, owner_name")
        flickr_photos = flickr_response.map do |flickr_photo|
            flickr_url = "https://live.staticflickr.com/#{flickr_photo.server}/#{flickr_photo.id}_#{flickr_photo.secret}.jpg"
            Photo.new(
                    url: flickr_url, 
                    user: User.last,
                    location: [flickr_photo.latitude.to_f, flickr_photo.longitude.to_f], 
                    latitude: flickr_photo.latitude.to_f, 
                    longitude: flickr_photo.longitude.to_f,
                    creation_date_time: flickr_photo.datetaken,
                    creator: flickr_photo.ownername
                )
        end
        flickr_photos
    end

    def get_flickr_photo
        flickr = Flickr.new(ENV["FLICKR_API_KEY"], ENV["FLICKR_SHARED_SECRET"])
        flickr_response = flickr.photos.getExif(photo_id: 52321569336)
        flickr_response
    end


  def photo_params
    params.require(:photo).permit(:url, :photo, :creation_date_time, :creator, :location, :focal_length, :camera, :aperture, :lens)
  end


end



