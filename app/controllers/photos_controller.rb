class PhotosController < ApplicationController
	def show 
		@api = Koala::Facebook::API.new(session[:access_token])
		@album_id = @api.fql_query("SELECT object_id FROM album WHERE name='Profile Pictures'")
		#@identifier = params[:id];
		#@profile_path = @api.get_picture(params[:id])
	end
end
