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

	@pics = @api.fql_query("SELECT src_big,src,src_width,src_height FROM photo WHERE aid='#{@profile_aid}'")

	end

	def tagged_photos
		@api = Koala::Facebook::API.new(session[:access_token])
		me = @api.get_object("me")
		@string = "SELECT pid FROM photo_tag WHERE subject=#{me["id"]}"
		@tagged = @api.fql_query("SELECT pid FROM photo_tag WHERE subject=#{me["id"]}")
	end

	def make
		return unless params[:url].include?("facebook.com") 
    	headers['Content-Type'] = 'image/jpeg' 
   		headers['Cache-Control'] = 'public' 
    	headers['Expires'] = 'Mon, 28 Jul 2020 23:30:00 GMT' 
    	open(params[:url]).read 
	end

end