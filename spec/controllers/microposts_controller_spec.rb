require 'spec_helper'

describe MicropostsController do
  before do
    User.delete_all
  end

  describe 'POST #upvote' do
    let(:user) { create(:user) }
    let(:micropost) { create(:micropost, user: user) }

    it 'increments the votes on the post' do
      post :upvote, use_route: :upvote, id: micropost

      micropost.reload
      expect(micropost.votes).to eq 1
    end

    it 'redirects to the user page' do
      post :upvote, use_route: :upvote, id: micropost

      expect(response).to redirect_to user_path(user)
    end
  end
end