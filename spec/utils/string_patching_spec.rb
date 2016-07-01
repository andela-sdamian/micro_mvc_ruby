require 'spec_helper'

describe 'String Patching' do
  describe '#snake_case' do
    context 'TaskController' do
      it { expect('TaskController'.snake_case).to eq 'task_controller' }
    end

    context 'Task' do
      it { expect('Task'.snake_case).to eq 'task' }
    end

    context 'Task::task' do
      it { expect('Task::task'.snake_case).to eq 'task/task' }
    end

    context 'Taskcontroller' do
      it { expect('Taskcontroller'.snake_case).to eq 'taskcontroller' }
    end

    context 'TaskControllerAction' do
      it { expect('TaskControllerAction'.snake_case).to eq 'task_controller_action' }
    end
  end

  describe '#camel_case' do
    context 'Task_controller' do
      it { expect('Task_controller'.camel_case).to eq 'TaskController' }
    end

    context 'Task__controller_action' do
      it { expect('Task__controller_action'.camel_case).to eq 'TaskControllerAction' }
    end

    context 'Task' do
      it { expect('Task'.camel_case).to eq 'Task' }
    end
  end

  describe '#constantize' do
    context '`Hash`' do
      it { expect('Hash'.constantize).to eq Hash }
    end

    context '`String`' do
      it { expect('String'.constantize).to eq String }
    end

    context '`Array`' do
      it { expect('Array'.constantize).to eq Array }
    end
  end

  describe '#to_plural' do
    context 'girl' do
      it { expect('girl'.to_plural).to eq 'girls' }
    end

    context 'buzz' do
      it { expect('buzz'.to_plural).to eq 'buzzes' }
    end

    context 'story' do
      it { expect('story'.to_plural).to eq 'stories' }
    end

    context 'toy' do
      it { expect('toy'.to_plural).to eq 'toys' }
    end

    context 'scarf' do
      it { expect('scarf'.to_plural).to eq 'scarves' }
    end

    context 'analysis' do
      it { expect('analysis'.to_plural).to eq 'analyses' }
    end

    context 'curriculum' do
      it { expect('curriculum'.to_plural).to eq 'curricula' }
    end

    context 'criterion' do
      it { expect('criterion'.to_plural).to eq 'criteria' }
    end

    context 'amoeba' do
      it { expect('amoeba'.to_plural).to eq 'amoebae' }
    end

    context 'focus' do
      it { expect('focus'.to_plural).to eq 'foci' }
    end

    context 'bureau' do
      it { expect('bureau'.to_plural).to eq 'bureaux' }
    end
  end
end
