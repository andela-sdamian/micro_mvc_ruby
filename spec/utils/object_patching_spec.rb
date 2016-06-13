require 'spec_helper'
describe 'Helpers' do
  context '#const_missing' do
    it { expect('Task'.constantize).to eq Task }

    it { expect('TaskController'.constantize).to eq TaskController }

    it { expect('Array'.constantize).to eq Array }
  end
end
