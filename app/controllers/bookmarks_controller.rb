class BookmarksController < ApplicationController

    def index
        @bookmarks = Bookmark.all
    end

    def show
        @bookmark = Bookmark.find(params[:id])
    end

    def new
        @bookmark = Bookmark.new
    end

    def create
        @bookmark = Bookmark.new(bookmark_params)
        @bookmark.user = current_user
        @bookmark.photo = Photo.find(params[:id])
        if @bookmark = Bookmark.save
            redirect_to bookmark_path(@bookmark)
        else 
            render :new, status: :unprocessable_entity
        end

    end

    def destroy
        @bookmark = Bookmark.find(params[:id])
    end

    private

    def bookmark_params
        params.require(:photo).permit(:user_id, :photo_id)
    end


end
