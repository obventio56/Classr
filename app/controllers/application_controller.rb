class ApplicationController < ActionController::Base
  include SessionsHelper
  include RolesHelper

  protect_from_forgery with: :exception
end
