class ApplicationController < ActionController::Base
  include SessionsHelper
  include RolesHelper
  include TestsHelper

  protect_from_forgery with: :exception
end
