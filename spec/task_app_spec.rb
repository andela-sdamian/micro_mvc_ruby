require 'spec_helper'

describe 'Task Application', type: :feature do
  after(:each) do
    Task.destroy_all
  end

  describe "GET '/' " do
    it 'redirects to default page' do
      visit '/'
      expect(page).to have_content('Task List')
      expect(page).to have_content('Pending Tasks')
      expect(page).to have_content('Completed Tasks')
    end
  end

  describe "GET '/invalid' route" do
    it 'returns a 404 page' do
      visit '/invalid'
      expect(page).to have_content('Ooops! page not found - 404')
      expect(page.status_code).to eq 404
    end
  end

  describe "GET '/task/:id'" do
    it 'returns a valid task' do
      create(:task)
      visit "/task/#{Task.last.id}"
      expect(page.status_code).to eq 200
    end
  end

  describe "POST '/task/new'" do
    it 'creates a new task' do
      visit '/task/new'
      task = build(:task)
      expect(page).to have_content('New Task')
      fill_in('task[title]', with: task.title)
      fill_in('task[body]', with: task.body)

      click_button('Create Task')
      expect(page).to have_content(task.title)
      expect(page).to have_content(task.body)
      expect(page.current_path).to eq "/task/#{Task.last.id}"
    end
  end

  describe "PATCH/PUT 'task/edit'" do
    it 'updates a task item' do
      create(:task)
      visit '/tasks'
      click_link('Edit')

      new_task = build(:new_task)
      expect(page.current_path).to eq "/task/#{Task.last.id}/edit"
      fill_in('task[title]', with: new_task.title)
      fill_in('task[body]', with: new_task.body)
      click_button('Update Task')

      expect(page.current_path).to eq "/task/#{Task.last.id}"
      expect(page).to have_content(new_task.title)
      expect(page).to have_content(new_task.body)
    end
  end

  describe "DELETE 'task/delete' " do
    it 'deletes a task' do
      create(:task)
      visit '/tasks'
      click_button('Delete')
      expect(Task.all.size).to eq 0
      expect(page.current_path).to eq '/'
    end
  end
end
