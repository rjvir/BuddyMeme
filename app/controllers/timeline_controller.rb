class TimelineController < ApplicationController
	def stream
		@api = Koala::Facebook::API.new(session[:access_token])
		begin
			#@graph_data = @api.get_object("/me/statuses", "fields"=>"message")
			@app_photo_data = @api.fql_query("SELECT attachment.media FROM stream WHERE filter_key in (SELECT filter_key FROM stream_filter WHERE uid=me() AND name = 'photos') AND app_id='124024574287414' LIMIT 500")

			#@test_query = @api.fql_query("SELECT pic_big FROM user WHERE uid='1200702'")
		rescue Exception=>ex
			puts ex.message
		end
	end
end
