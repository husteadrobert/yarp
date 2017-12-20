class Business < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :reviews
end