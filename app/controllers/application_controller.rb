class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # include Turbolinks::Redirection
end
