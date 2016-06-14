require 'spec_helper'
require 'todo_app/app/models/task'

describe MicroMvcRuby::Sequel do
  after(:each) do
    Task.destroy_all
  end

  describe '#save' do
    let(:task) { Task.new }

    it 'saves a new object to database' do
      new_task_data = build(:task)
      task.created_at = new_task_data.created_at
      task.title = new_task_data.title
      task.body = new_task_data.body
      task.status = new_task_data.status
      task.save!

      expect(Task.all.size).to eq 1
      expect(Task.last.title).to eq new_task_data.title
      expect(Task.last.body).to eq new_task_data.body
      expect(Task.last.status).to eq new_task_data.status
    end
  end

  describe '#update' do
    it 'updates a record in the database' do
      old_task_data = create(:task)
      new_task_data = build(:new_task)
      task = Task.last
      task.title = new_task_data.title
      task.body = new_task_data.body
      task.status = new_task_data.status
      task.save!

      expect(Task.last.title).not_to eq old_task_data.title
      expect(Task.last.body).not_to eq old_task_data.body
      expect(Task.last.status).not_to eq old_task_data.status
    end
  end

  describe '#destroy' do
    it 'deletes a row in a table' do
      create(:task)
      Task.last.destroy

      expect(Task.all.size).to eq 0
    end
  end

  describe '#find_by' do
    it 'finds a record with the supplied params' do
      new_task = create(:task)
      task = Task.find_by(title: new_task.title)

      expect(task.title).to eq new_task.title
    end
  end

  describe '#all' do
    it 'returns all record in the table' do
      2.times { create(:task) }

      expect(Task.all.size).to eq 2
    end
  end

  describe '#where' do
    it 'returns all record matching the pattern specified' do
      2.times { create(:task) }
      tasks = Task.where('status like ?', '%pending%')
      expect(tasks.size).to eq 2
    end
  end

  describe '#last' do
    it 'returns the last record in the table' do
      1.times do
        create(:task)
        create(:new_task)
      end
      last_task_data = build(:new_task)

      expect(Task.last.title).to eq last_task_data.title
    end
  end

  describe '#first' do
    it 'returns the first record in the table' do
      1.times do
        create(:task)
        create(:new_task)
      end
      first_task_data = build(:task)

      expect(Task.first.title).to eq first_task_data.title
    end
  end

  describe '#destroy_all' do
    it 'deletes all record in the table' do
      2.times do
        create(:task)
        create(:new_task)
      end
      Task.destroy_all

      expect(Task.all.size).to eq 0
    end
  end
end