require 'rails_helper'

describe User do 
  let(:user) {create(:user)}

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end
  it "is invalid without a name" do
    expect(build(:user, name: nil)).to have(1).errors_on(:name)
  end
  it "is invalid with a name greater than 50 characters" do 
    expect(build(:user, name: 'a' * 51)).to have(1).errors_on(:name)
  end
  it "is invalid without an email" do
    expect(build(:user, email: nil)).to have(2).errors_on(:email)
  end

  describe "invalid email" do 
    let(:user_1) {create(:user, email: 'foo@bar.com')}

    it "is invalid with a duplicate email" do 
      user_1
      expect(build(:user, email: 'foo@bar.com')).to have(1).errors_on(:email)
    end
    it "is invalid with invalid format" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end
    it "is case sensitive" do
      expect(build(:user, email: 'FOO@BAR.COM')).to have(0).errors_on(:email)
    end
    it "is valid" do
      addresses = %w[user@foo.COM U_S-ER@f.b.org a+b@baz.cn]
      addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end

  describe "invalid password" do
    it "is invalid without a password" do 
      expect(build(:user, password: nil)).not_to be_valid
    end
    it "is invalid without a matching password confirmation" do
      expect(build(:user, password_confirmation: 'somepaswrod')).not_to be_valid
    end
    it "is invalid with a short password" do 
      expect(build(:user, password: 'pass')).not_to be_valid
    end
  end

  describe "return value of authenticate method" do 
    context "with invalid password" do 
      it "should not return the user" do 
        expect(User.find_by(email: 'wrong_email@bar.com')).not_to eq user
      end
    end
    context "with valid password" do 
      it "should return the user" do
        expect(User.find_by(email: user.email)).to eq user
      end
    end
  end

  describe "remember_token" do 
    it "should not be blank" do
      user
      expect(user.remember_token).not_to be_blank 
    end
  end

  describe "following" do 
    let(:user) {create(:user, email: 'foo@baz.com')}
    let(:other_user) {create(:user)}
    before do
      user.follow!(other_user)
      other_user.follow!(user)
    end
    it "should be_following other_user" do 
      expect(user.following?(other_user)).to eq(true)
    end

    it "following should include other_user" do 
      expect(user.following).to include(other_user)
    end

    it "should unfollow other_user" do 
      user.unfollow!(other_user)
      expect(user.following).not_to include(other_user)
    end

    it "followers should include other user" do 
      expect(user.followers).to include(other_user)
    end
  end


end