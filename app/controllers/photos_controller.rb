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

#  @pics = @api.get_connections(@profile_aid,"photos")
	@pics = @api.fql_query("SELECT src_big,src_big_width,src_big_height,src,src_width,src_height FROM photo WHERE aid='#{@profile_aid}'")

	end

	def tagged_photos
		@api = Koala::Facebook::API.new(session[:access_token])
		@tagged_photos = @api.fql_multiquery(:query1 => "SELECT pid FROM photo_tag WHERE subject=#{params[:id]}", 
			:query2 => "SELECT src, src_big,src_big_width,src_big_height,src_width,src_height FROM photo WHERE pid IN (SELECT pid from #query1)"
		)
	end

	def proxy
	    return unless params[:url].include?("fbcdn")
  		data = open(params[:url]).read
  		send_data data, :type => 'image/jpeg', :disposition => 'inline'
	end

end