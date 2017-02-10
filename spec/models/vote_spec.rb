require 'spec_helper'

describe Vote do
  before do
    User.delete_all
  end

  context 'when voting on users own post' do
    it 'should not be valid' do
      user = create(:user)
      micropost = create(:micropost, user: user)
      vote = build(:vote, user: user, micropost: micropost)

      expect(vote).not_to be_valid
    end
  end
end