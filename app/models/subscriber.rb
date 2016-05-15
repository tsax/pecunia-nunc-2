class Subscriber < ActiveRecord::Base
  before_save { |subscriber| subscriber.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :token, presence: false,
  									uniqueness: {case_sensitive: true }
	scope :find_active, -> { where(active: true) }
end
