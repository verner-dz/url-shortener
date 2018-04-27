module UrlCodec

  CHARACTERS = [*"a".."z"] + [*"A".."Z"] + [*"0".."9"]
  INCREMENT_VALUE = 1_000_000_000_000

  def self.encode(i)
    i += INCREMENT_VALUE
    slug = ""
    base = CHARACTERS.length

    while i > 0
      slug << CHARACTERS[i.modulo(base)]
      i /= base
    end

    return slug.reverse
  end
end
