require 'spec_helper'

describe 'splunk::config::install::user' do

  context 'with defaults for all parameters' do
    it { should contain_class('splunk::config::install::user') }
  end

  # manage
  [true, false, "yes", "no", :absent].each { |x|
    context "with manage => #{x}" do
      let(:params) { { :manage => x } }
      it do
        expect {
          should contain_class('splunk::config::install::user')
	}
      end
    end
  }

  ["foo"].each { |x|
    context "with manage => #{x}" do
      let(:params) { {:manage => x } }
      it do
        expect {
          should contain_class('splunk::config::install::user')
        }.to raise_error(Puppet::Error, /manage must be one of undef, true, false, yes, or no/)
      end
    end
  }

  # ensure
  ['present', 'absent', 'role', :undef].each { |x|
    context "with ensure => #{x}" do
      let(:params) { { :ensure => x } }
      it do
        expect {
          should contain_class('splunk::config::install::user')
	}
      end
    end
  }

  ["foo"].each { |x|
    context "with ensure => #{x}" do
      let(:params) { { :ensure => x } }
      it do
        expect {
          should contain_class('splunk::config::install::user')
	}.to raise_error(Puppet::Error, /ensure must be one of present, absent, or role/)
      end
    end
  }

  #system
  [true, false, "yes", "no", :undef].each { |x|
    context "with system => #{x}" do
      let(:params) { { :system => x } }
      it do
        expect {
          should contain_class('splunk::config::install::user')
	}
      end
    end
  }

  ["foo"].each { |x|
    context "with system => #{x}" do
      let(:params) { { :system => x } }
      it do
        expect {
          should contain_class('splunk::config::install::user')
        }.to raise_error(Puppet::Error, /system must be one of true, false, yes, or no/)
      end
    end
  }

  #expiry
  ['absent', '2015-01-02', '2012-12-11', :undef].each { |x|
    context "with expiry => #{x}" do
      let(:params) { { :expiry => x } }
      it do
        expect {
          should contain_class('splunk::config::install::user')
	}
      end
    end
  }

  ["foo", "2012-1-23", "2015-01-1"].each { |x|
    context "with system => #{x}" do
      let(:params) { { :system => x } }
      it do
        expect {
          should contain_class('splunk::config::install::user')
        }.to raise_error(Puppet::Error, /system must be one of true, false, yes, or no/)
      end
    end
  }

  # forcelocal (condensed)
  [true, false, "yes", "no", :absent].each { |x|
    context "with forcelocal => #{x}" do
      let(:params) { { :forcelocal => x } }
      it do
        expect {
          should contain_class('splunk::config::install::user')
	}
      end
    end
  }

  context 'with forcelocal => foo' do
    let(:params) { {:forcelocal => 'foo'} }
    it do
      expect {
        should contain_class('splunk::config::install::user')
      }.to raise_error(Puppet::Error, /forcelocal must be true, false, yes, or no/)
    end
  end

end


