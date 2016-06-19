require 'spec_helper'
require_relative '../helpers/router_helper'

describe MicroMvcRuby::Routing::Router do
  def draw(&block)
    router = MicroMvcRuby::Routing::Router.new
    router.draw(&block).route_data
  end

  context 'endpoints' do
    context "get '/tasks', to: 'task#index'" do
      subject do
        draw { get '/tasks', to: 'task#index' }
      end

      route_data = { path: '/tasks',
                     pattern: [%r{^/tasks$}, []],
                     controller_and_action: ['TaskController', :index]
                   }

      it { is_expected.to eq route_data }
    end
  end

  context "get '/tasks/:id', to: 'task#show'" do
    subject do
      draw { get '/tasks/:id', to: 'task#show' }
    end

    route_data = { path: '/tasks/:id',
                   pattern: [%r{^/tasks/(?<id>[^/?#]+)$}, ['id']],
                   controller_and_action: ['TaskController', :show]
                 }

    it { is_expected.to eq route_data }
  end

  context "get '/tasks/:id/edit', to: 'task#edit'" do
    subject do
      draw { get '/tasks/:id/edit', to: 'task#edit' }
    end

    regexp = %r{^/tasks/(?<id>[^/?#]+)/edit$}

    route_data = { path: '/tasks/:id/edit',
                   pattern: [regexp, ['id']],
                   controller_and_action: ['TaskController', :edit]
                 }

    it { is_expected.to eq route_data }
  end

  context "get 'task/:task_id/done/:done_id', to: 'task#done'" do
    subject do
      draw { get '/task/:task_id/done/:done_id', to: 'task#done' }
    end

    regexp = %r{^/task/(?<task_id>[^/?#]+)/done/(?<done_id>[^/?#]+)$}
    route_data = { path: '/task/:task_id/done/:done_id',
                   pattern: [regexp, %w(task_id done_id)],
                   controller_and_action: ['TaskController', :done]
                 }

    it { is_expected.to eq route_data }
  end
end
