require 'rails_helper'

feature 'reviewing restaurants' do
  before{Restaurant.create name: 'KFC'}
  scenario 'Users can leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'so so '
  end
end
