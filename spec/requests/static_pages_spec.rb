require 'spec_helper'

describe "StaticPages" do
  subject { page }

 describe "Home page" do
    before { visit root_path 
      click_link "Home"}

    it { should have_selector('h1',    text: 'Sample App') }
    it { should have_selector('title', text: full_title_page('')) }
    it { should_not have_selector 'title', text: '| Home' }
  end


  describe "Help page" do
    before { visit help_path
    click_link "Help" }

    it { should have_selector('h1',    text: 'Help') }
    it { should have_selector('title', text: full_title_page('Help')) }
  end

  describe "About page" do
    before { visit about_path 
      click_link "About"}

    it { should have_selector('h1',    text: 'About') }
    it { should have_selector('title', text: full_title_page('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path 
      click_link "Contact"}

    it { should have_selector('h1',    text: 'Contact') }
    it { should have_selector('title', text: full_title_page('Contact')) }
  end
end
