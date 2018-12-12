class HomeController < ApplicationController
	before_action :doorkeeper_authorize!,except: [:index]
  def index
  end

  def test
  	render json: current_resource_owner
  	# render :json => {"hi" => "hello"}
  end
end
