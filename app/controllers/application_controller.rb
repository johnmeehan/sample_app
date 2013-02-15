class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper  #8.14 to include helper funtions in controller
end
 