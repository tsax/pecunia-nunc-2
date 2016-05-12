class Subscriber < ActiveRecord::Base
	scope :find_active, -> { where(active: true) }
end
