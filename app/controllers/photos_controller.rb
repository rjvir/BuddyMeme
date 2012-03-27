class PhotosController < ApplicationController
	def show 
		@identifier = params[:id];
	end
end
