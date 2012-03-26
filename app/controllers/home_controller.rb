class HomeController < ApplicationController

  def facebook_cookies
    @facebook_cookies ||= Koala::Facebook::OAuth.new(YOUR_APP_ID, YOUR_SECRET).get_user_info_from_cookie(cookies)
  end
  
  def index
  	@access_token = facebook_cookies['access_token']
 	@graph = Koala::Facebook::GraphAPI.new(@access_token)
  end
end
