class Museum < ActiveRecord::Base
  has_many :picture, as: :imageable
end
