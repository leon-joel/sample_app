require 'spec_helper'

describe "Static pages" do
  describe "Home page" do
    it "should have the content 'Sample App'" do
      # Capybara の visit 機能を使ってURLアクセスをシミュレート
      visit '/static_pages/home'
      
      # Capybara の提供する page変数にアクセスした結果が格納されている
      expect(page).to have_content('Sample App')
    end
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
  end

  describe "About page" do
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end
  end
end
