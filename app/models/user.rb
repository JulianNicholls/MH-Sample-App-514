class User < ApplicationRecord

  validates :name, presence: true, length: { in: 3..50 }

  validates :email, presence: true, length: { in: 7..255 }
end
