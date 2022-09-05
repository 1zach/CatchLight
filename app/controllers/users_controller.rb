class UsersController < ApplicationController

  def show
    @user = current_user
    @trips_with_photos = current_user.photos.group_by(&:trip)
  end
end
