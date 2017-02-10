require 'spec_helper'

describe MicropostsController do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost, user: user) }
  let(:nicu) { create(:user, name: 'nicu') }
  let(:nicus_post) { create(:micropost, user: nicu, content: 'hello') }

  before do
    User.delete_all

    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'POST #upvote' do
    it 'increments the votes on the post' do
      post :upvote, use_route: :upvote, id: nicus_post
      expect(nicus_post.votes.count).to eq 1
    end

    it 'redirects to the user page' do
      post :upvote, use_route: :upvote, id: nicus_post

      expect(response).to redirect_to user_path(nicu)
    end

    it 'does not allow a user to vote on a post more than once' do
      post :upvote, use_route: :upvote, id: nicus_post
      post :upvote, use_route: :upvote, id: nicus_post

      expect(nicus_post.votes.count).to eq 1
    end
  end

  describe 'GET #show' do
    it 'displays the micropost page' do
      get :show, id: micropost

      expect(response.code).to eq '200'
    end

    it 'assigns a micropost variable' do
      get :show, id: micropost

      expect(assigns(:micropost)).to eq micropost
    end
  end
end