class PhotosController < ApplicationController
	def show 
		@api = Koala::Facebook::API.new(session[:access_token])
		@identifier = params[:id];
		@string = "SELECT aid FROM album WHERE owner='#{params[:id]}'"
		@aids = @api.fql_query("SELECT aid name FROM album WHERE owner='#{params[:id]}'")
		#@profile_path = @api.get_picture(params[:id])
	end
end
