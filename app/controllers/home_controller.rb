class HomeController < ApplicationController
	protect_from_forgery
  def index
  		session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/home/callback')
		@auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"friends_photos,publish_stream,read_stream") 	
		puts session.to_s + "<<< session"

  	respond_to do |format|
			 format.html {  }
		 end
  end

  def callback
  	if params[:code]
  		# acknowledge code and get access token from FB
		  session[:access_token] = session[:oauth].get_access_token(params[:code])
		  redirect_to friends_path
	end		

		 # auth established, now do a graph call:


	#end

	def friends
		@api = Koala::Facebook::API.new(session[:access_token])
		begin
			#@graph_data = @api.get_object("/me/statuses", "fields"=>"message")
			@top_friends = @api.fql_multiquery(
			:query1 => "SELECT actor_id FROM stream WHERE source_id=me() LIMIT 0,150",
			:query2 => "SELECT uid, name, pic_square FROM user WHERE uid IN (SELECT actor_id from #query1) AND uid <> me() LIMIT 0,15",
			:query3 => "SELECT uid2 FROM friend WHERE uid1 = me()",
			:query4 => "SELECT name, uid,pic_square FROM user WHERE uid IN (SELECT uid2 from #query3)"
			)
			#@test_query = @api.fql_query("SELECT pic_big FROM user WHERE uid='1200702'")
		rescue Exception=>ex
			puts ex.message
		end

  
 		respond_to do |format|
		 format.html {   }			 
		end

	end

end
