# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: "test", email: "test1@gmail.com", password: "aaaaaaaag", password_confirmation: "aaaaaaaag")}

  subject {@user}

	  it { should respond_to (:name)}
  	  it { should respond_to (:email)}
  	  it { should respond_to (:password_digest)}
      it { should respond_to (:password)}
      it { should respond_to (:password_confirmation)}
      it { should respond_to (:remember_token)}
      it { should respond_to (:authenticate)}
      it { should respond_to (:microposts)}
  	  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " "
    	@user.email = "" }
    it { should_not be_valid }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end
 describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "micropost Association" do
    before{@user.save}
    let!(:older_micropost) do
      FactoryGirl.create(:micropost,user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost,user: @user, created_at: 1.hour.ago) 
    end
    it "should have the right micropost in the right order" do
      @user.microposts.should == [newer_micropost,older_micropost]
    end
    it "should destroy the associated microposts" do
      microposts = @user.microposts
      @user.destroy
      microposts.each do |micropost|
        lambda do 
          Micropost.find(micropost.id)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
