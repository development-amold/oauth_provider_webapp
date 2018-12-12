class ApplicationController < ActionController::Base
	
  	

  # GET /me.json
  def me
    respond_to do |format| 
     format.json {render json: current_resource_owner} 
    end
  end

  private

  # Find the user that owns the access token
  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
