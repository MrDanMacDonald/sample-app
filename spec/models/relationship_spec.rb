require 'spec_helper'

describe Relationship do
  let!(:follower) {create(:user, :email => 'dan@danmacd.com')}
  let!(:followed) {create(:user, :email => 'danm.macdonald@gmail.com')}
  let(:relationship) {follower.relationships.build(followed_id: followed.id)}

  describe "validations" do 
    it "when followed_id is not present" do 
      relationship.followed_id = nil
      expect(relationship).to_not be_valid
    end
    it "when follower_id is not present" do 
      relationship.follower_id = nil
      expect(relationship).to_not be_valid
    end
  end
end
