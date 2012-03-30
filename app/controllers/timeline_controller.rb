class TimelineController < ApplicationController
	def stream
		@api = Koala::Facebook::API.new(session[:access_token])
		begin
			#@graph_data = @api.get_object("/me/statuses", "fields"=>"message")
			@filter_key_data = @api.fql_query("SELECT app_id from stream")

			#@test_query = @api.fql_query("SELECT pic_big FROM user WHERE uid='1200702'")
		rescue Exception=>ex
			puts ex.message
		end
	end
end
