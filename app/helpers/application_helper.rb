module ApplicationHelper
  def display_photo(photo)
    if photo.photo.key
      render 'shared/cloudinary_tag', photo: photo
    else
      render 'shared/image_tag', photo: photo
    end
  end
end
