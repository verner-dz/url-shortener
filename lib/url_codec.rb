module UrlCodec

  CHARACTERS = [*"a".."z"] + [*"A".."Z"] + [*"0".."9"]

  def self.encode(i)
    slug = ""

    base = CHARACTERS.length

    while i > 0
      slug << CHARACTERS[i.modulo(base)]
      i /= base
    end

    return slug.reverse
  end
end
