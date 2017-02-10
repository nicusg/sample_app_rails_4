require 'spec_helper'

describe 'working with posts', feature: true do
  before do
    User.delete_all

    @nicu = create(:user, email: 'nicu@example.com')
    @lenny = create(:user, email: 'lenny@example.com')
    create(:micropost, user: @nicu, content: 'something interesting')
  end

  it 'allows users to upvote posts' do
    sign_in(@lenny)

    visit user_path(@nicu)

    within '.microposts li:first' do
      click_on 'upvote'
    end

    expect(page).to have_content 'Votes: 1'
  end

  it 'does not allow a user to upvote their own post' do
    sign_in(@nicu)

    visit user_path(@nicu)

    expect(page).not_to have_content('upvote')
  end

  it 'allows users to navigate to a posts page' do
    sign_in(@nicu)

    visit user_path(@nicu)

    within '.microposts li:first' do
      click_on 'view'
    end

    expect(page).to have_content 'something interesting'
    expect(page).not_to have_content @nicu.name
  end
end