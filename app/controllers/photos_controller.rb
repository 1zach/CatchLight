class PhotosController < ApplicationController
  require 'flickr'
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :authenticate_user!, only: :toggle_favorite
  before_action :set_photo, only: %i[ edit update destroy]

  def index
    if params[:query_location].present? && params[:query_month].present?
      catch_light_photos = get_catch_light_photos(params[:query_location], params[:query_month])
      new_location = Geocoder.search(params[:query_location])
      text = params[:query_location]
      year = 2021
      radius = params[:query_radius]
      month = (params[:query_month])
      flickr_photos = []
      until flickr_photos.count >= 20 do
        start_date = "#{year}-#{month}-01"
        end_date = "#{year}-#{month}-28"
        flickr_photos += get_flickr_photos(new_location.first.data["lat"], new_location.first.data["lon"], text, start_date, end_date, radius)
        year -= 1
        if year == 1995
          break
        end
      end
      @photos = catch_light_photos + flickr_photos
    else
      @photos = Photo.all
    end
    @markers = @photos.map do |photo|
      {
        id: photo.id,
        lat: photo.latitude,
        lng: photo.longitude,
        url: photo.url || photo.photo.url,
        info_window: render_to_string(partial: "info_window", locals: {photo: photo})
      }
    end
  end

  def show

    if params[:flickr]
      @photo = Photo.new(
        url: params[:url],
        focal_length: exif("Focal Length").nil? ? 'None' : exif("Focal Length").first,
        aperture: exif("Aperture").nil? ? 'None' : exif("Aperture").first,
        creation_date_time: exif("Date and Time (Original)").nil? ? 'None' : creation_date_time_formatter(exif("Date and Time (Original)").first),
        camera: exif("Model").nil? ? 'None' : exif("Model").first,
        location: [params["latitude"], params["longitude"]]
      )
      @markers = [
        {
          lat: params['latitude'],
          lng: params['longitude'],
          url: @photo.url,
          info_window: render_to_string(partial: "info_window", locals: {photo: @photo})
        }
      ]

    else
      set_photo
      
      @markers = [
        {
          lat: @photo.latitude,
          lng: @photo.longitude,
          url: @photo.url,
          info_window: render_to_string(partial: "info_window", locals: {photo: @photo})
        }
      ]
    end


  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user
    @time = creation_date_time_formatter(photo_params["creation_date_time"]) 
    @photo.creation_date_time = @time

    @photo.creator = current_user.first_name
    if @photo.save
      redirect_to photo_path(@photo)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_path, status: :see_other
  end

  def toggle_favorite
    @photo = Photo.find_by(id: params[:id])
    current_user.favorited?(@photo) ? current_user.unfavorite(@photo) : current_user.favorite(@photo)
    redirect_to photo_path(@photo), status: :see_other
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def get_catch_light_photos(query_location, query_month, query_distance = 100)
    Photo.near(query_location, query_distance, order: :distance)
         .where("SELECT EXTRACT(MONTH FROM creation_date_time) = ?", query_month)
  end


  def get_flickr_photos(latitude, longitude, text, start_date, end_date, radius)
    flickr = Flickr.new(ENV["FLICKR_API_KEY"], ENV["FLICKR_SHARED_SECRET"])

    flickr_response = flickr.photos.search(
      has_geo: 1, # Any photo that has been geotagged
      lat: latitude,
      lon: longitude,
      geo_context: 2, # Geo context outdoors
      accuracy: 16, # Recorded accuracy level of the location information: Street is ~16
      radius: radius, # A valid radius used for geo queries
      per_page: 150, #Number of photos shown per page
      content_type: 1,
      sort: "interestingness-desc",
      text: text,
      min_taken_date: start_date,
      max_taken_date: end_date,
      extras: "geo, date_taken, owner_name"
    )

    #filtered_images = filter_flickr_images(flickr_response)

    flickr_response.map do |flickr_photo|
      flickr_url = "https://live.staticflickr.com/#{flickr_photo.server}/#{flickr_photo.id}_#{flickr_photo.secret}.jpg"
      Photo.new(
        id: flickr_photo.id,
        url: flickr_url,
        user: User.last,
        location: [flickr_photo.latitude.to_f, flickr_photo.longitude.to_f],
        latitude: flickr_photo.latitude.to_f,
        longitude: flickr_photo.longitude.to_f,
        creation_date_time: flickr_photo.datetaken,
        creator: flickr_photo.ownername,
        flickr: true
      )
    end
  end

  def get_flickr_additional_information(photo_id)
    flickr = Flickr.new(ENV["FLICKR_API_KEY"])# ENV["FLICKR_SHARED_SECRET"])
    @flickr = flickr.photos.getExif(photo_id: photo_id)
    #@flickr = flickr.photos.getExif(photo_id.to_i)
  end

  def photo_params
    params.require(:photo).permit(:url, :photo, :creation_date_time, :creator, :location, :focal_length, :camera, :aperture, :lens)
  end

  def get_exif
    raw_exif = get_flickr_additional_information(params[:id]).exif
    useful_exif = raw_exif.select { |hash| hash['tag'] == "Lens" ||
    hash['tag'] == "FNumber" ||
    hash['tag'] == "Aperture" ||
    hash['tag'] == "Model" ||
    hash['tag'] == "DateTimeOriginal"||
    hash['tag'] == "FocalLength" ||
    hash['tag'] == "CreateDate"
    }
      new_exif = useful_exif.map do |hash|
        {hash['label'] => hash['raw']}
      end


    end


  def exif(value)
    get_exif
    exif_value = get_exif.find do |hash|
      if hash.key?(value)
        return hash.values
      end
    end

   return exif_value
  end

  def creation_date_time_formatter(value)
    "#{value.gsub(/:/, '-').to_date.to_fs} #{value[-8..-1]}".to_datetime
  end
  #end

  #def filter_flickr_images(images)
  #  return filter_flickr_images
  #end
end
