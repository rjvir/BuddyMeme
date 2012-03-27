class PhotosController < ApplicationController
	def show 
		@identifier = params[:id];
		profile_path = @graph.get_picture(params[:id])
	end
end
