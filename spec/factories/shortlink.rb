FactoryBot.define do
  factory :shortlink do |f|
    f.sequence(:slug) { FFaker::AddressUK.postcode.gsub(/\s+/, "") }
    f.sequence(:destination) { FFaker::Internet.http_url }
  end
end
