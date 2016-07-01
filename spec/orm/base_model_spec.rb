require 'spec_helper'

describe MicroMvcRuby::BaseModel do
  let(:default_task) { build(:task) }
  let(:new_task) { build(:new_task) }

  after(:each) { Task.destroy_all }

  describe '#save' do
    let(:task) { Task.new }

    it 'saves a new record' do
      task.created_at = default_task.created_at
      task.title = default_task.title
      task.body = default_task.body
      task.status = default_task.status

      task.save

      expect(Task.all.size).to eq 1
      expect(Task.last.title).to eq default_task.title
      expect(Task.last.body).to eq default_task.body
      expect(Task.last.status).to eq default_task.status
    end
  end

  describe '#update' do
    it 'updates an exisitng record' do
      create(:task)
      task = Task.last

      task.update(title: new_task.title,
                  body: new_task.body,
                  status: new_task.status)

      expect(Task.last.title).not_to eq default_task.title
      expect(Task.last.body).not_to eq default_task.body
      expect(Task.last.status).not_to eq default_task.status
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
    it 'finds a record with the supplied parameters' do
      create(:task)

      task = Task.find_by(title: default_task.title, 
                          status: default_task.status)

      expect(task.title).to eq default_task.title
      expect(task.status).to eq default_task.status
    end
  end

  describe '::all' do
    it 'returns all record' do
      2.times { create(:task) }

      expect(Task.all.size).to eq 2
    end
  end

  describe '::where' do
    it 'returns all record with a like matcher' do
      2.times { create(:task) }

      tasks = Task.where('status like ?', '%pending%')

      expect(tasks.size).to eq 2
    end
  end

  describe '::first' do
    it 'returns the first record' do
      create(:task)
      create(:new_task)

      expect(Task.first.title).to eq default_task.title
    end
  end

  describe '::last' do
    it 'returns the last record' do
      create(:task)
      create(:new_task)

      expect(Task.last.title).to eq new_task.title
    end
  end

  describe '::find' do
    it 'finds a record by id' do
      create(:task)

      expect(Task.find(Task.last.id).title).to eq default_task.title
    end
  end

  describe '::destroy' do
    it 'deletes a record by id' do
      create(:task)

      Task.destroy(Task.last.id)

      expect(Task.all.size).to eq 0
    end
  end

  describe '::destroy_all' do
    it 'deletes all record' do
      create(:task)
      create(:new_task)

      Task.destroy_all

      expect(Task.all.size).to eq 0
    end
  end
end
