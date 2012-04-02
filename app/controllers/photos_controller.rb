class PhotosController < ApplicationController
	def show 
		@api = Koala::Facebook::API.new(session[:access_token])
		@identifier = params[:id];
		session[:id] = @identifier;
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
	@pics = @api.fql_query("SELECT src_big,pid,src_big_width,src_big_height,src,src_width,src_height FROM photo WHERE aid='#{@profile_aid}'")

	end

	def tagged_photos
		@api = Koala::Facebook::API.new(session[:access_token])
		@tagged_photos = @api.fql_multiquery(:query1 => "SELECT pid FROM photo_tag WHERE subject=#{params[:id]}", 
			:query2 => "SELECT src,pid,src_big,src_big_width,src_big_height,src_width,src_height FROM photo WHERE pid IN (SELECT pid from #query1)"
		)
		@identifier = params[:id]
	end

	def proxy
	  return unless params[:url].include?("fbcdn")
  	data = open(params[:url]).read
  	send_data data, :type => 'image/jpeg', :disposition => 'inline'
	end
	
	def make
	  @identifier = params[:uid]
	  #params[:pid]
	  @at = session[:access_token]
	  @friendid = session[:id]
	  @api = Koala::Facebook::API.new(session[:access_token])
	  @photo = @api.fql_query("SELECT src_big,src_big_width,src_big_height,pid FROM photo WHERE pid='#{params[:pid]}'")
	end
	
	def writer
	  data = params[:data]
    File.open("public/test.png", 'w') do |f|
      f.write(Base64.decode64(data))
    end
    #  	send_data data, :type => 'image/jpeg', :disposition => 'inline'    
  end
  
  def upload
    url = "http://talktomindy.com/memes/#{params[:hash]}.png"
	  @api = Koala::Facebook::API.new(session[:access_token])
#    @api.put_picture(@foo.remote_image_path,{}, album_id)
    @uid = session[:id]
    @response = @api.put_object('me', 'photos', {:message => "Message", :url=>url, :tags =>"[{'tag_uid': '#{@uid}', 'x':45, 'y':45}]" })
#    @response = @api.put_picture(url, {:message => "Message", :tags =>{:x=>45, :y=>45, :to=>session[:id]} })
    #puts response
    @id = @response["id"]
    #args = {:x=>45, :y=>45}
    #@api.put_object(id, "tags/#{session[:id]}", args)
#    @api.rest_call('photos.addTag', args)
  end
end