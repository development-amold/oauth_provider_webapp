# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  include ApplicationHelper
  def new
    if !params[:client_id].blank?
      @client_params = encrypt_str(params.reject! { |k| k == "action" || k == "controller" })
    else
      @client_params = ""    
    end
    super
  end

  def create
    @safe_params_hash = {}
    if params["user"].has_key?("client_uri") && !params[:user][:client_uri].blank?
      @client_hash = decrypt_str(params[:user][:client_uri])
      params1 = ActionController::Parameters.new({
        client_id: @client_hash[:client_id],
        redirect_uri: @client_hash[:redirect_uri],
        response_type: @client_hash[:response_type],
        state: @client_hash[:state]
      })
      @safe_params = params1.permit(:client_id,:redirect_uri,:response_type,:state)  
      @safe_params_hash = @safe_params.to_h        
    end


    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?

    unless @safe_params_hash.blank?
      redirect_to "#{oauth_authorization_path}?#{@safe_params_hash.to_query}"
    else
        respond_with resource, location: after_sign_in_path_for(resource)    
    end    
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   puts "-PERMIT-------#{keys}----------"
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
