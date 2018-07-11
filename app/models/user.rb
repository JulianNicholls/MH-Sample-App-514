class User < ApplicationRecord

  validates :name, presence: true, length: { in: 3..50 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  validates :email, 
      presence: true, 
      length: { in: 6..255 },
      format: { with: EMAIL_REGEX },
      uniqueness: { case_sensitive: false }
end
