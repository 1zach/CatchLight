class PhotosController < ApplicationController
  require 'flickr'
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_photos, only: %i[show edit update destroy]

  def index
    if params[:query_location].present? && params[:query_date].present?
      catch_light_photos = get_catch_light_photos(params[:query_location], params[:query_date])
      new_location = Geocoder.search(params[:query_location])
      flickr_photos = get_flickr_photos(new_location.first.data["lat"], new_location.first.data["lon"])
      @photos = flickr_photos + catch_light_photos
    else
     @photos = Photo.all
    end

    @markers = @photos.map do |photo|
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
      render :new, status: :unprocessable_entity
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

  def get_catch_light_photos(query_location, query_date, query_distance = 5000)
    creation_date_time = query_date.to_date

    Photo.near(query_location, query_distance, order: :distance)
         .where("photos.creation_date_time > ?", creation_date_time)

  end


  def get_flickr_photos(latitude, longitude)
    flickr = Flickr.new(ENV["FLICKR_API_KEY"], ENV["FLICKR_SHARED_SECRET"])

    flickr_response = flickr.photos.search(
      has_geo: 1, # Any photo that has been geotagged
      lat: latitude,
      lon: longitude,
      geo_context: 2, # Geo context outdoors
      accuracy: 16, # Recorded accuracy level of the location information: Street is ~16
      radius: 0.5, # A valid radius used for geo queries
      per_page: 150, #Number of photos shown per page
      sort: "relevance",
      extras: "geo, date_taken, owner_name"
    )

    flickr_response.map do |flickr_photo|
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
  end

  def get_flickr_additional_information(photo_id)
    flickr = Flickr.new(ENV["FLICKR_API_KEY"], ENV["FLICKR_SHARED_SECRET"])
    flickr.photos.getExif(photo_id)
  end

  def photo_params
    params.require(:photo).permit(:url, :photo, :creation_date_time, :creator, :location, :focal_length, :camera, :aperture, :lens)
  end
end
