class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token

  before_create :create_activation_digest

  validates :first_name,              presence: true, length: { maximum: 50 }
  validates :last_name,               presence: true, length: { maximum: 50 }
  validates :nickname,                presence: true, length: { maximum: 50 }
  validates :encrypted_email_address, presence: true
  validates :encrypted_phone_number,  presence: true
  validates :encrypted_zip_code,      presence: true
  validates :gender,                  inclusion: { in: ["male", "female"] }
  validates :birthdate,               presence: true

  has_secure_password
  validates :password,                presence: true, length: { minimum: 6, maximum: 20 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
