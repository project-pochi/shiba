class User < ActiveRecord::Base


validates :first_name,              presence: true, length: { maximum: 50 }
validates :last_name,               presence: true, length: { maximum: 50 }
validates :encrypted_email_address, presence: true
validates :encrypted_phone_number,  presence: true
validates :encrypted_zip_code,      presence: true
validates :gender,                  inclusion: { in: ["male", "female"] }
validates :birthdate,               presence: true
#validates :disabled,                presence: true

has_secure_password
validates :password,                presence: true, length: { minimum: 6, maximum: 20 }

end
