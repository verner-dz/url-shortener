require 'rails_helper'

describe Shortlink do

  let!(:shortlink) { FactoryBot.create(:shortlink)}
  let(:new_shortlink) { Shortlink.new()}
  let(:last_id) { Shortlink.last.id}

  describe "Validations" do
    it "validates presence of destination" do
      expect(shortlink).to validate_presence_of(:destination)
    end
  end

  describe "returns a generated slug" do
    it "should return the slug in the right encoded format" do
      expect(new_shortlink.generate_slug(last_id)).to eq("rLHWfKg")
    end
  end
end
