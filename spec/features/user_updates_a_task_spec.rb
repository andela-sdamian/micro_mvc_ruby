require 'spec_helper'

describe 'User updates a task', type: :feature do
  let(:new_task) { build(:new_task) }
  before(:all) { create(:task) }
  after(:each) { Task.destroy_all }

  scenario 'when updating an exisiting task' do
    visit "/task/#{Task.last.id}/edit"

    fill_in('task[title]', with: new_task.title)
    fill_in('task[body]', with: new_task.body)

    click_button('Update Task')

    expect(page).to have_content(new_task.title)
    expect(page).to have_content(new_task.body)
    expect(page.status_code).to eq 200
  end
end
