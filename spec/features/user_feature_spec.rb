require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end

  context 'when not logged in' do
    it "user can't create restaurant" do
      visit('/')
      expect(current_path).not_to eq('/restaurants/new')
      expect(page).not_to have_link('Create Restaurant')
    end

  end

  context 'when user has not created' do
    it 'user can not delete/edit restaurants' do
      visit ('/')
      sign_up_and_in('vale@gmail.com')
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link('Sign out')
      sign_up_and_in('makers@gmail.com')
      expect(page).not_to have_link('Edit KFC')
      expect(page).not_to have_link('Delete KFC')
    end
  end

end
