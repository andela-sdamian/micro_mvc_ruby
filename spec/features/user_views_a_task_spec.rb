require 'spec_helper'

describe 'User views a task', type: :feature do
  let(:task) { build(:task) }
  before(:all) { create(:task) }
  after(:each) { Task.destroy_all }

  scenario 'when viewing a particular task' do
    visit "/task/#{Task.last.id}"
  
    expect(page).to have_content(task.title)
    expect(page).to have_content(task.body)  
    expect(page.status_code).to eq 200
  end
end
