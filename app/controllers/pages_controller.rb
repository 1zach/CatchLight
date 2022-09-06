class PagesController < ApplicationController
  layout 'application'
  skip_before_action :authenticate_user!, only: [ :home, :about_us ]

  def home
  end

  def about_us
  end
end
