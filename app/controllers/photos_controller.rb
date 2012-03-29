class PhotosController < ApplicationController
	def show 
		@api = Koala::Facebook::API.new(session[:access_token])
		@identifier = params[:id];
		#@string = "SELECT aid FROM album WHERE owner='#{params[:id]}'"
		#@profile_pics = @api.fql_multiquery(
		#	:query1 => "SELECT aid, name FROM album WHERE owner='#{params[:id]}'",
		#	:query2 => "SELECT src_big FROM photo WHERE aid IN (SELECT name from #query1)"
		#	)

		@aids = @api.fql_query("SELECT aid, name FROM album WHERE owner='#{params[:id]}'")

		@aids.each do |photo_object|
			if photo_object["name"]=="Profile Pictures"
				@profile_aid = photo_object["aid"]
				break
			end
		end
		
		#@pics = @api.fql_query("SELECT src_big FROM photo WHERE aid='#{@profile_aid}'")

	end

end
