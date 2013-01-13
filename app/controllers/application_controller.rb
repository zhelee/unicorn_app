class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :test, only: [:index]
  

  def this
  end

end
