class TimelineController < ApplicationController
	def stream
		@api = Koala::Facebook::API.new(session[:access_token])
		begin
			#@graph_data = @api.get_object("/me/statuses", "fields"=>"message")
			@app_data = @api.fql_query("SELECT app_data FROM stream WHERE source_id='204060336365834'")

			#@test_query = @api.fql_query("SELECT pic_big FROM user WHERE uid='1200702'")
		rescue Exception=>ex
			puts ex.message
		end
	end
end
