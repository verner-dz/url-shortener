class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    begin
      uri = URI.parse(value)
      valid_uri = valid_url_format?(value) && !uri.host.nil?
    rescue URI::InvalidURIError
      valid_uri = false
    end

    unless valid_uri
      record.errors[attribute] << (options[:message] || "is not an url")
    end
  end

  def valid_url_format?(url)
    url_regex = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,63}(:[0-9]{1,5})?(\/.*)?\z/ix
    url_regex.match?(url)
  end
end
