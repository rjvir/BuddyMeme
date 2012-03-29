class PhotosController < ApplicationController
	def show 
		@api = Koala::Facebook::API.new(session[:access_token])
		@identifier = params[:id];
		#@string = "SELECT aid FROM album WHERE owner='#{params[:id]}'"
		begin
			@aids = @api.fql_query("SELECT aid, name FROM album WHERE owner='#{params[:id]}'")
		rescue Exception=>ex
			puts ex.message
		end

		begin
		@aids.each do |photo_object|
			if photo_object["name"]=="Profile Pictures"
				@profile_aid = photo_object["aid"]
				break
			end
		end
		rescue Exception=>ex
			puts ex.message
		end 
		#@profile_path = @api.get_picture(params[:id])
		begin
			@pics = @api.fql_query("SELECT src_big FROM photo WHERE aid='#{@profile_aid}'")
		rescue Exception=>ex
			puts ex.message
		end

	end

end
