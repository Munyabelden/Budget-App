# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Entities', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }
  let(:category) { Category.create(name: 'Category', user:) }

  before do
    login_as(user, scope: :user)
    Entity.create(name: 'Transaction 1', amount: 100)
    Entity.create(name: 'Transaction 2', amount: 200)
    visit category_entities_path(category)
  end

  scenario 'User can see the list of entities within a category' do
    within('.devise-head') do
      expect(page).to have_css('h1', text: 'Transactions')
    end
  end

  scenario 'User can click on "Add a new transaction" link' do
    click_link 'Add a new transaction'
    expect(page).to have_current_path(new_category_entity_path(category))
  end
end
