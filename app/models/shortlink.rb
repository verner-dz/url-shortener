class Shortlink < ActiveRecord::Base
  validates :destination, presence: true, url: true

  def generate_slug(last_id)
    return UrlCodec.encode(last_id + 1)
  end
end
