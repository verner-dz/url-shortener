require "rails_helper"

describe ShortlinksController do
  let!(:shortlink) { FactoryBot.create(:shortlink) }

  describe "POST create", type: :request do
    context "creates a new shortlink" do
      before(:each) do
        @success_shortlink_params = { destination: FFaker::Internet.http_url }
        post shortlinks_path, params: { shortlink: @success_shortlink_params, format: :js }
      end

      it "should return a success status on create" do
        expect(response).to have_http_status(:success)
      end

      it "should create a new shortlink" do
        expect(Shortlink.last.destination).to eq(@success_shortlink_params[:destination])
      end
    end

    context "doesn't create duplicate shortlink" do
      before(:each) do
        shortlink_params = { destination: shortlink.destination }
        post shortlinks_path, params: { shortlink: shortlink_params, format: :js }
      end

      it "should return a success status on create" do
        expect(response).to have_http_status(:success)
      end

      it "should not have created a shortlink" do
        expect(Shortlink.all.count).to eq(1)
      end

      it "should use the existing shortlink" do
        expect(Shortlink.last.destination).to eq(shortlink.destination)
      end
    end
  end

  describe "GET find_and_redirect", type: :request do
    context "finds and redirects to destination" do
      before(:each) do
        get find_and_redirect_path(shortlink.slug)
      end

      it "should have a status of record found" do
        expect(response).to have_http_status(:found)
      end

      it "should redirect to the shortlink destination" do
        expect(response).to redirect_to(shortlink.destination)
      end
    end

    context "renders a 404" do
      it "returns a 404 status" do
        get find_and_redirect_path(FFaker::AddressUK.postcode.gsub(/\s+/, ""))
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
