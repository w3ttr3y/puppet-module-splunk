require 'spec_helper_acceptance'

install_puppet

describe 'splunk class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors based on the example' do
      pp = <<-EOS
        class { 'splunk':
          }
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    #describe service('consul') do
    #  it { should be_enabled }
    #end

    #describe command('consul version') do
    #  it { should return_stdout /Consul v0\.2\.0/ }
    #end

  end
end
