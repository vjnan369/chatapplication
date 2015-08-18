class ApplicationController < ActionController::Base
	require "opentok"
  before_filter :config_opentok
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

   private
  def config_opentok
    if @opentok.nil?
      @opentok = OpenTok::OpenTok.new 45297362, "df0ccc74f4392e9bea2899d8c8535beab569dd62"
    end
  end
end
