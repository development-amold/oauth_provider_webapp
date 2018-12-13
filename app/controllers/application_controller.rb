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

  # protected
    def after_sign_in_path_for(resource)
      unless cookies.signed[:continue].blank?
        @store_cookie = cookies.signed[:continue]
        cookies.delete :continue
        oauth_authorization_path @store_cookie
      else
        super  
      end
      # cookies.signed[:continue] || stored_location_for(resource) || root_path
    end

end
