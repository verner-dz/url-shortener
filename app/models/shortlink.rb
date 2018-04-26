class Shortlink < ActiveRecord::Base
  validates :destination, presence: true
end
