require 'spec_helper'
require 'todo_application/app/models/task'

describe MicroMvcRuby::BaseModel do
  after(:each) do
    Task.destroy_all
  end

  describe '#save' do
    let(:task) { Task.new }

    it 'saves a new record' do
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
    it 'updates an exisitng record' do
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
    it 'deletes an existing record' do
      create(:task)
      Task.last.destroy

      expect(Task.all.size).to eq 0
    end
  end

  describe '::find_by' do
    it 'finds a record with the supplied parameter' do
      new_task = create(:task)
      task = Task.find_by(title: new_task.title)

      expect(task.title).to eq new_task.title
    end
  end

  describe '::all' do
    it 'returns all record' do
      2.times { create(:task) }

      expect(Task.all.size).to eq 2
    end
  end

  describe '::where' do
    it 'returns all record matching the pattern specified' do
      2.times { create(:task) }
      tasks = Task.where('status like ?', '%pending%')
      expect(tasks.size).to eq 2
    end
  end

  describe '::first' do
    it 'returns the first record' do
      1.times do
        create(:task)
        create(:new_task)
      end
      first_task_data = build(:task)

      expect(Task.first.title).to eq first_task_data.title
    end
  end

  describe '::last' do
    it 'returns the last record' do
      1.times do
        create(:task)
        create(:new_task)
      end
      last_task_data = build(:new_task)

      expect(Task.last.title).to eq last_task_data.title
    end
  end

  describe '::find' do
    it 'finds a record by id' do
      task_data = create(:task)
      id = Task.last.id
      expect(Task.find(id).title).to eq task_data.title
    end
  end

  describe '::destroy' do
    it 'deletes a record by id' do
      create(:task)
      id = Task.last.id
      Task.destroy(id)
      expect(Task.all.size).to eq 0
    end
  end

  describe '::destroy_all' do
    it 'deletes all record' do
      2.times do
        create(:task)
        create(:new_task)
      end
      Task.destroy_all

      expect(Task.all.size).to eq 0
    end
  end
end
