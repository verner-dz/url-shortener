require 'rails_helper'

module Test
  UrlValidatable = Struct.new(:destination) do
    include ActiveModel::Validations

    validates :destination, url: true
  end
end


describe UrlValidator, type: :model do
  subject { Test::UrlValidatable.new("http://wwww.google.com") }

  it { is_expected.to be_valid }

  describe "invalid url formats" do
    it "is invalid if url has spaces" do
      subject.destination = "http://www example.com"
      subject.valid?
      expect(subject.errors[:destination]).to match_array("is not an url")
    end

    it "is invalid if it's a string" do
      subject.destination = "blahblahblah"
      subject.valid?
      expect(subject.errors[:destination]).to match_array("is not an url")
    end

    it "is invalid if url does not have http" do
      subject.destination = "www.example.com"
      subject.valid?
      expect(subject.errors[:destination]).to match_array("is not an url")
    end

    it "is invalid if url has invalid syntax" do
      subject.destination = "http://www,example.com"
      subject.valid?
      expect(subject.errors[:destination]).to match_array("is not an url")
    end

    it "is invalid if url is incomplete" do
      subject.destination = "http://example"
      subject.valid?
      expect(subject.errors[:destination]).to match_array("is not an url")
    end
  end

  describe "valid url formats" do
    it "is valid if url has http" do
      subject.destination = "http://www.example.com"
      expect(subject.valid?).to eq(true)
    end

    it "is valid if url has https" do
      subject.destination = "https://www.example.com"
      expect(subject.valid?).to eq(true)
    end

    it "is valid if url has other TLDs" do
      subject.destination = "http://www.example.nyc"
      expect(subject.valid?).to eq(true)
    end

    it "is valid if url includes hyphens" do
      subject.destination = "http://www.example-example.com"
      expect(subject.valid?).to eq(true)
    end

    it "is valid if url has a subdomain" do
      subject.destination = "http://www.login.example.com"
      expect(subject.valid?).to eq(true)
    end

    it "is valid if url has integers" do
      subject.destination = "http://www.23z.com"
      expect(subject.valid?).to eq(true)
    end
  end
end
