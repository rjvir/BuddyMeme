# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
BuddyMeme::Application.initialize!

# config/environment.rb
# in Rails::Initializer.run do |config|
config.action_controller.allow_forgery_protection = false