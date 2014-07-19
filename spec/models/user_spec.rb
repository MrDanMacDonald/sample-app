require 'rails_helper'

describe User do 

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
    let!(:user) {build(:user)}
    let!(:user_1) {create(:user, email: 'foo@bar.com')}

    it "is invalid with a duplicate email" do 
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
      expect(build(:user, email: 'FOO@BAR.COM')).not_to be_valid
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
    let(:user) {create(:user)}

    describe "with invalid password" do 
      it "should not return the user" do 
        expect(User.find_by(email: 'wrong_email@bar.com')).not_to eq user
      end
    end

    describe "with valid password" do 
      it "should return the user" do
        expect(User.find_by(email: user.email)).to eq user
      end
    end
  end

  describe "remember_token" do 
    let(:user) {create(:user)}
    it "should not be blank" do
      user
      expect(user.remember_token).not_to be_blank 
    end
  end

end