require 'spec_helper'

describe Relationship do
  # let!(:follower) {create(:user)}
  # let!(:followed) {create(:user)}
  # let(:relationship) {follower.relationships.build(followed_id: followed.id)}

  describe "validations" do 
    it "when followed_id is not present" do 
      # relationship.followed_id = nil
      # expect(relationship).to_not be_valid
    end
    it "when follower_id is not present" do 
      # relationship.follower_id = nil
      # expect(relationship).to_not be_valid
    end
  end
end
