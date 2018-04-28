class Shortlink < ActiveRecord::Base
  validates :destination, presence: true, url: true

  CHARACTERS = [[*"a".."z"] + [*"A".."Z"] + [*"0".."9"]].flatten.freeze
  URL_ENCODING_INCREMENT_VALUE = 1_000_000_000_000

  def generate_slug(i)
    i += URL_ENCODING_INCREMENT_VALUE + 1
    slug = ""
    base = CHARACTERS.length

    while i > 0
      slug << CHARACTERS[i.modulo(base)]
      i /= base
    end
    return slug.reverse
  end

end
