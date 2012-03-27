class PhotosController < ApplicationController
	def show 
		@api = Koala::Facebook::API.new(session[:access_token])
		@identifier = params[:id];
		@profile_path = @api.get_picture(params[:id])
	end
end
