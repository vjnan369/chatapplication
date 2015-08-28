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
      @opentok = OpenTok::OpenTok.new 45325402, "8d2f9eea218fd8046bdc9457a660d157dcbc281b"
    end
  end
end
