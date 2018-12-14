module ApplicationHelper
	def encrypt_str payload
		crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets[:crypt_key])
		crypt.encrypt_and_sign(payload)                   
	end

	def decrypt_str payload
		crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets[:crypt_key])   		
		crypt.decrypt_and_verify(payload)
	end	
end
