class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save { email.downcase! }

  has_secure_password

  validates :name, presence: true, length: { in: 3..50 }
  
  validates :email, 
      presence: true, 
      length: { in: 6..255 },
      format: { with: EMAIL_REGEX },
      uniqueness: { case_sensitive: false }
      
      validates :password, 
      presence: true, 
      length: { minimum: 6 },
      allow_nil: true

      # Return the hash digest of the given string
      def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end
end
