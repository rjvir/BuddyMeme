class PhotosController < ApplicationController
	def show 
		@identifier = params[:id];
		profile_path = @api.get_picture(params[:id])
	end
end
