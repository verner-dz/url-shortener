class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    begin
      uri = URI.parse(value)
      valid_uri = uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
      valid_uri = false
    end

    unless valid_uri
      record.errors[attribute] << (options[:message] || "is not an url")
    end
  end
end
