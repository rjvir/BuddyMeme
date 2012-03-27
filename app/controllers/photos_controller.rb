class PhotosController < ApplicationController
	def show 
		@api = Koala::Facebook::API.new(session[:access_token])
		@identifier = params[:id];
		#@string = "SELECT aid FROM album WHERE owner='#{params[:id]}'"
		@aids = @api.fql_query("SELECT aid, name FROM album WHERE owner='#{params[:id]}'")

		@aids.each do |object|
			if object["name"]=="Profile Pictures"
				@profile_aid = object["aid"]
				break
			end
		end
		#@profile_path = @api.get_picture(params[:id])

		@pics = @api.fql_query("SELECT src_big FROM photo WHERE aid='#{@profile_aid}'")
		
	end
end
