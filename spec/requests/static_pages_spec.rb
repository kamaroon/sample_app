require 'spec_helper'

describe "StaticPages" do
  describe "Home pages" do
    it "Should have content Sample App" do
    	visit '/static_pages/home'
      # page.should have_content('Sample App')
      page.should have_selector('h1',:text =>"Sample App")
    end
    it "Should have right title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title',:text => "Ruby on Rails Tutorial Sample App | Home")
    end
  end

  describe "Help pages" do
    it "Should have content Help" do
    	visit '/static_pages/help'
      page.should have_content('Help')
    end
    it "Should have right title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title',:text => "Ruby on Rails Tutorial Sample App | Help")
    end
  end

  describe "About pages" do
    it "Should have content 'About us'" do
      visit '/static_pages/about'
      page.should have_content('About Us')
    end
    it "Should have right title 'About us'" do
      visit '/static_pages/about'
      page.should have_selector('title',:text => "Ruby on Rails Tutorial Sample App | About Us")
    end
  end

end
