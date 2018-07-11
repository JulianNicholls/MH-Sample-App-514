class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save { email.downcase! }

  validates :name, presence: true, length: { in: 3..50 }

  
  validates :email, 
      presence: true, 
      length: { in: 6..255 },
      format: { with: EMAIL_REGEX },
      uniqueness: { case_sensitive: false }
end
