require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

  before do
    login_as(user, scope: :user)
    Category.create(name: 'Category 1', icon: 'icon', user: user)
    Category.create(name: 'Category 2', icon: 'icon', user: user)
    visit categories_path
  end

  scenario 'User can see the list of categories' do
    within('.devise-head') do
      expect(page).to have_css('h1', text: 'Categories')
    end

    within('.card', text: 'Category 1') do
      expect(page).to have_css('.icon')
      expect(page).to have_css('.card-title', text: 'Category 1')
      expect(page).to have_content('Total Amount:')
    end

    within('.card', text: 'Category 2') do
      expect(page).to have_css('.icon')
      expect(page).to have_css('.card-title', text: 'Category 2')
      expect(page).to have_content('Total Amount:')
    end
  end

  scenario 'User can click on "Add a new category" link' do
    click_link 'Add a new category'
    expect(page).to have_current_path(new_category_path)
  end
end
