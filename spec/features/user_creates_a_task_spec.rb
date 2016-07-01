require 'spec_helper'

describe 'User creates a task', type: :feature do
  let(:task) { build(:task) }
  after(:each) { Task.destroy_all }

  scenario "when they visit 'the create new' task path" do
    visit '/task/new'

    expect(page).to have_content('New Task')
    expect(page.status_code).to eq 200
  end

  scenario 'when creating a new task' do
    visit '/task/new'

    fill_in('task[title]', with: task.title)
    fill_in('task[body]', with: task.body)

    click_button('Create Task')

    expect(page.current_path).to eq "/task/#{Task.last.id}"
    expect(page).to have_content(task.title)
    expect(page).to have_content(task.body)
    expect(page.status_code).to eq 200
  end
end
