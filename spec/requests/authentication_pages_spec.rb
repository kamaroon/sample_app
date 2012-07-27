require 'spec_helper'

describe "AuthenticationPages" do
	subject { page }

  describe "signin" do

    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error') }
      it {should have_error_message('Invalid')}

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

  describe " With valid Information" do
  	let(:user) {FactoryGirl.create(:user)}
  	before { valid_signin(user) }
  	it { should have_selector('title', text: user.name)}
  	it { should have_link('Profile',href: user_path(user))}
    it { should have_link('Settings', href: edit_user_path(user))}
  	it { should have_link('Sign out', href: signout_path)}
  	it { should_not have_link('sign_in', href: signin_path)}
    describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
    end
  end

  describe "Authorisation" do
    describe "for no-signed-in user" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
   
      end
    end
  end
end
end


