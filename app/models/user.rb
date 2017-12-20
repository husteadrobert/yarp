class User < ActiveRecord::Base
  has_secure_password validations: false

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :reviews

  def has_reviewed?(business)
    self.reviews.exists?(business_id: business.id)
  end
end