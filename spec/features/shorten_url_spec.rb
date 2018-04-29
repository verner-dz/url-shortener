require 'rails_helper'

feature 'visitor enters url to shorten' do
  context 'with valid url' do
    it "should show a success message", js: true do
      shorten("http://www.example.com")
      expect(page).to have_css('.text-center', text: 'Your url is shortened!')
    end
  end

  context 'with invalid url' do

    it "shows a validation message if url is invalid", js: true do
      shorten("www.example.com")
      expect(page).to have_css('.alert', text: 'Destination is not a valid url')
    end

    it "shows a validation message if url is blank", js: true do
      shorten("")
      expect(page).to have_css('.alert', text: "Destination can't be blank")
    end
  end

  def shorten(url)
    visit root_path
    fill_in 'shortlink[destination]', with: url
    click_button 'Shorten'
  end
end
