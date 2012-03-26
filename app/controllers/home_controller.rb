class HomeController < ApplicationController
  before_filter :parse_facebook_cookies

  def parse_facebook_cookies
  #@facebook_cookies ||= Koala::Facebook::OAuth.new(204060336365834, b09cd7497b065848e232db1fe98365d7).get_user_info_from_cookie(cookies)

  # If you've setup a configuration file as shown above then you can just do
  # @facebook_cookies ||= Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
  end

  def index

  end
end
