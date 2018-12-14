# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  include ApplicationHelper
  # GET /resource/sign_in
  def new
    puts "---ENCRYPTION------------#{encrypt_str("amol")}------REQ---#{request.original_url}---"
    @client_params = encrypt_str(params)
    if params.has_key?("client_id")
      cookies.signed[:continue] = params #-----return url
    end
    
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
