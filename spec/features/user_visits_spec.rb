require 'spec_helper'

describe 'User visits', type: :feature do
  scenario 'when visiting the homepage' do
    visit '/'

    expect(page).to have_content('Task List')
    expect(page).to have_content('Pending Tasks')
    expect(page).to have_content('Completed Tasks')
    expect(page.status_code).to eq 200
  end

  scenario 'when visiting an invalid path' do
    visit '/invalid'

    expect(page).to have_content('Ooops! page not found - 404')
    expect(page.status_code).to eq 404
  end
end
