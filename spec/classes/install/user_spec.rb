
require 'spec_helper'

describe 'splunk::install::user' do
  
  it { should compile }

  context 'with defaults for all parameters' do
    it { should contain_class('splunk::install::user')
	 should contain_user('splunk') }
  end

  # manage
  [true, "yes", :absent].each { |x|
    context "with manage => #{x}" do
      let(:params) { { :manage => x } }
      it do
        expect {
          should contain_class('splunk::config::install::user')
	  should contain_user('splunk')
	}
      end
    end
  }

  # false, no
  [false, "no"].each { |x|
    context "with manage => #{x}" do
      let(:params) { { :manage => x } }
      it do
        expect {
	  #should contain_class('splunk::config::install::user')
	  should not_contain_user('splunk')
        }
      end
    end
  }


end
