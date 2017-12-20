class Review < ActiveRecord::Base
  validates_presence_of :body, :user_id, :business_id
  belongs_to :user
  belongs_to :business
  validates_uniqueness_of :user_id, scope: :business_id

  def self.recent_reviews(size=5)
    self.all.order("created_at DESC").limit(size)
  end
end