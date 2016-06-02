require 'spec_helper'

describe 'String Patching' do
  describe '#snake_case' do
    context 'TodoController' do
      it { expect('TodoController'.snake_case).to eq 'todo_controller' }
    end

    context 'Todo' do
      it { expect('Todo'.snake_case).to eq 'todo' }
    end

    context 'Todo' do
      it { expect('Todo'.snake_case).to eq 'todo' }
    end

    context 'Todo::task' do
      it { expect('Todo::task'.snake_case).to eq 'todo/task' }
    end

    context 'TodoController' do
      it { expect('TodoController'.snake_case).to eq 'todo_controller' }
    end

    context 'todocontroller' do
      it { expect('Todocontroller'.snake_case).to eq 'todocontroller' }
    end

    context 'TodoControllerAction' do
      it { expect('TodoControllerAction'.snake_case).to eq 'todo_controller_action' }
    end
  end

  describe '#camel_case' do
    context 'Todo_controller' do
      it { expect('Todo_controller'.camel_case).to eq 'TodoController' }
    end

    context 'Todo__controller_action' do
      it { expect('Todo__controller_action'.camel_case).to eq 'TodoControllerAction' }
    end

    context 'Todo' do
      it { expect('Todo'.camel_case).to eq 'Todo' }
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

  describe '#pluralize' do
    context 'girl' do
      it { expect('girl'.pluralize).to eq 'girls' }
    end

    context 'buzz' do
      it { expect('buzz'.pluralize).to eq 'buzzes' }
    end

    context 'story' do
      it { expect('story'.pluralize).to eq 'stories' }
    end

    context 'toy' do
      it { expect('toy'.pluralize).to eq 'toys' }
    end

    context 'scarf' do
      it { expect('scarf'.pluralize).to eq 'scarves' }
    end

    context 'analysis' do
      it { expect('analysis'.pluralize).to eq 'analyses' }
    end

    context 'curriculum' do
      it { expect('curriculum'.pluralize).to eq 'curricula' }
    end

    context 'criterion' do
      it { expect('criterion'.pluralize).to eq 'criteria' }
    end

    context 'amoeba' do
      it { expect('amoeba'.pluralize).to eq 'amoebae' }
    end

    context 'focus' do
      it { expect('focus'.pluralize).to eq 'foci' }
    end

    context 'bureau' do
      it { expect('bureau'.pluralize).to eq 'bureaux' }
    end
  end
end
