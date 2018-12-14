module ApplicationHelper
	def encrypt_str payload
		len   = ActiveSupport::MessageEncryptor.key_len
		salt  = SecureRandom.random_bytes(len)
		key   = ActiveSupport::KeyGenerator.new('uri').generate_key(salt, len) 
		crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets[:crypt_key])
		encrypted_data = crypt.encrypt_and_sign(payload)                   
		 		
	end

	def decrypt_str payload
		crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets[:crypt_key])   		
		crypt.decrypt_and_verify(payload)
	end	
end
