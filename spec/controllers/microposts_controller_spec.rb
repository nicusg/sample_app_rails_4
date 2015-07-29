require 'spec_helper'

describe MicropostsController do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost, user: user) }

  before do
    User.delete_all
  end

  describe 'POST #upvote' do

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