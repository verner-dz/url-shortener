class Shortlink < ActiveRecord::Base
  validates :destination, presence: true, url: true
end
