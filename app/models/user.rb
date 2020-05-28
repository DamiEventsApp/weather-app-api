class User < ApplicationRecord
  has_secure_password
  validates :email, :password_digest, presence: true

end
