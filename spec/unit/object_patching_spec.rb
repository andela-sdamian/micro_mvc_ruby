require 'spec_helper'

describe 'Object Patching' do
  context '#const_missing' do
    it { expect('String'.constantize).to eq String }

    it { expect('Hash'.constantize).to eq Hash }

    it { expect('Array'.constantize).to eq Array }
  end
end
