require 'spec_helper'
describe 'spm_monitor' do

  context 'with defaults for all parameters' do
    it { should contain_class('spm_monitor') }
  end
end
