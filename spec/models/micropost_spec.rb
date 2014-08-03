require 'spec_helper'

describe Micropost do
  
  let(:user) {create(:user)}
  let(:micropost) {create(:micropost, user_id: user.id)}

  it "has a valid factory" do 
    expect(micropost).to be_valid
  end

  describe "invalid micropost" do 
    it "is invalid without a user_id" do 
      micropost[:user_id] = nil
      expect(micropost).not_to be_valid
    end
    it "is invalid with blank content" do 
      micropost[:content] = nil
      expect(micropost).not_to be_valid
    end
    it "is invalid with more than 140 characters" do 
      micropost[:content] = "a" * 141
      expect(micropost).not_to be_valid
    end
  end

  describe "micropost associations" do 
      let!(:user) {create(:user)}
      let!(:older_micropost) {create(:micropost, user: user, created_at: 2.day.ago)}
      let!(:newer_micropost) {create(:micropost, user: user, created_at: 1.day.ago)}
      it "should order microposts newest to oldest" do 
        expect(user.microposts.to_a).to eq [newer_micropost, older_micropost]
      end
  end

end
