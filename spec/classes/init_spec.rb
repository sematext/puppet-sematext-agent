require 'spec_helper'
describe 'spm_monitor' do
  context 'with defaults for all parameters' do
    it { is_expected.to contain_class('spm_monitor') }
  end
end
