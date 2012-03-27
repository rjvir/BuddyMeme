class PhotosController < ApplicationController
	def show 
		@api = Koala::Facebook::API.new(session[:access_token])
		@identifier = params[:id];
		@string = 'SELECT aid, owner, name, object_id FROM album WHERE owner='@identifier'';
		@album_id = @api.fql_query('SELECT aid, owner, name, object_id FROM album WHERE owner='@identifier'')
		#@profile_path = @api.get_picture(params[:id])
	end
end
