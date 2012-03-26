class ApplicationController < ActionController::Base
  #protect_from_forgery
  before_filter :parse_facebook_cookies
  def parse_facebook_cookies
 	@facebook_cookies = Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
  end
end
