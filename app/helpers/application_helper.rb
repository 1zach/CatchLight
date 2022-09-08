module ApplicationHelper
  def display_photo(photo)
    if photo.photo.key
      render 'shared/cloudinary_tag', photo: photo
    else
      render 'shared/image_tag', photo: photo
    end
  end

    def show_photo(photo)
      if photo.photo.key
        render 'shared/show_page_cloudinary', photo: photo
      else
        render 'shared/show_page_apiPhoto', photo: photo
      end
    end

    def index_photo(photo)
      if photo.photo.key
        render 'shared/hover_cloudinary_tag', photo: photo
      else
        render 'shared/hover_image_tag', photo: photo
      end
    end

end
