require 'spec_helper'
include ApplicationHelper

describe "UserPages" do
 subject { page }

  describe "signup page" do
  
    before { visit signup_path }
    
    let(:submit) {"Create my account"}

    describe "With Invalid Information " do
      
      it "should not create  a user" do
        expect { click_button submit }.not_to change(User, :count)        
      end
    end
    describe "With Valid Information" do
      
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

    end


    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title_page('Sign up')) }
  end

  describe "profile pages" do
   let(:user) {FactoryGirl.create(:user)}
    let!(:m1) {FactoryGirl.create(:micropost, user: user, content: "Foo")}
    let!(:m2) {FactoryGirl.create(:micropost, user: user, content: "Bar")}
    before { visit user_path(user) }

    it{ should have_selector('h1', text: user.name)}
    it{ should have_selector('title', text: user.name)}
    describe "microposts" do
      it {should have_content(m1.content)}
      it {should have_content(m2.content)}
      it {should have_content(user.microposts.count)}
    end
  end

  # describe "edit" do
  #   let(:user) { FactoryGirl.create(:user) }
  #   before do
  #     sign_in user
  #     visit edit_user_path(user)
  #   end

  #   describe "page" do
  #     it { should have_selector('h1', text: "Update Your Profile")}
  #     it { should have_selector('title',text: "Edit User")}
  #     it { should have_link('change', href: "http://gravatar.com/emails")}
  #   end

  #   describe "with Invalid Information" do
  #     before { click_button "Save Changes"}
  #     it { should have_content ('error')}
  #   end

  #   describe "with valid information" do
  #     let(:new_name)  { "New Name" }
  #     let(:new_email) { "new@example.com" }
    
  #     before do
  #       fill_in "Name",             with: new_name
  #       fill_in "Email",            with: new_email
  #       fill_in "Password",         with: user.password
  #       fill_in "Confirm Password", with: user.password
  #       click_button "Save Changes"
  #     end
    
  #     it { should have_selector('title', text: new_name) }
  #     it { should have_selector('div.alert.alert-success') }
  #     it { should have_link('Sign out', href: signout_path) }
  #     specify { user.reload.name.should  == new_name }
  #     specify { user.reload.email.should == new_email }
  
end
