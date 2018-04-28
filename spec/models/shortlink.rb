require 'rails_helper'

describe Shortlink do

  let!(:shortlink) { FactoryBot.create(:shortlink)}

  describe "Validations" do
    it "validates presence of destination" do
      expect(shortlink).to validate_presence_of(:destination)
    end
  end

  describe "returns a generated slug" do
    it "should return a slug" do
      last_id = Shortlink.last.id
      new_shortlink = Shortlink.new()
      expect(new_shortlink.generate_slug(last_id)).not_to eq(nil)
    end
  end
end
