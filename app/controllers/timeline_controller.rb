class TimelineController < ApplicationController
	def stream
		@api = Koala::Facebook::API.new(session[:access_token])
		begin
			#@graph_data = @api.get_object("/me/statuses", "fields"=>"message")
			@filter_key_data = @api.fql_query("SELECT post_id, actor_id, target_id, message FROM stream WHERE filter_key in (SELECT filter_key FROM stream_filter WHERE uid=me() AND type='newsfeed') AND is_hidden = 0
")

			#@test_query = @api.fql_query("SELECT pic_big FROM user WHERE uid='1200702'")
		rescue Exception=>ex
			puts ex.message
		end
	end
end
