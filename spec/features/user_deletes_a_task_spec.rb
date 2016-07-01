require 'spec_helper'

describe 'User deletes a task', type: :feature do
  before(:all) { create(:task)  }
  after(:each) { Task.destroy_all }

  scenario 'when deleting an exisiting task' do
    visit '/tasks'

    click_button('Delete')

    expect(page).to have_content 'You have no pending task!'
    expect(page.current_path).to eq '/'
    expect(page.status_code).to eq 200
  end
end
