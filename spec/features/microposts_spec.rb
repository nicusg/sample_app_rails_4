require 'spec_helper'

describe 'working with posts', feature: true do
  before do
    User.delete_all

    @nicu = create(:user, email: 'nicu@example.com')
    @lenny = create(:user, email: 'lenny@example.com')
    create(:micropost, user: @nicu)
  end

  it 'allows users to upvote comments' do
    sign_in(@lenny)

    visit user_path(@nicu)

    within '.microposts li:first' do
      click_on 'upvote'
    end

    expect(page).to have_content 'Votes: 1'
  end
end