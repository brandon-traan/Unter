class User < ApplicationRecord
  has_many :bookings
  has_many :cars, through: :bookings
  enum roles: [:Customer, :Admin, :SuperAdmin]
  before_save { self.email = email.downcase }
  validates :firstname,  presence: true, length: { maximum: 20 }
  validates :lastname, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :phone, presence: true, length: { maximum: 10, minimum: 10 }, allow_nil: true
  validates :licenseN, presence: true, length: { maximum: 9, minimum: 9 },
                    uniqueness: true, allow_nil: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    
    BCrypt::Password.create(string, cost: cost)
  end
  
  def admin?
    self.role == 'Admin'
  end
  
  def superadmin?
    self.role = 'SuperAdmin'
  end
end
