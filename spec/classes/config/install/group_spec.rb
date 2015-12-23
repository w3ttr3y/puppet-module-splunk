
require 'spec_helper'

describe 'splunk::config::install::group' do
  it { should compile }

  context 'with defaults for all parameters' do
    it { should contain_class('splunk::config::install::group') }
  end
  #manage must be one of undef, true, false, yes, or no
  #ensure must be one of present, absent, or role
  #forcelocal must be true, false, yes, or no
  #system must be one of true, false, yes, or no

  # manage
  [true, false, "yes", "no", :absent, :undef].each { |x|
    context "with manage => #{x}" do
      let(:params) { { :manage => x } }
      it do
        expect {
          should contain_class('splunk::config::install::group')
	}
      end
    end
  }

  ["foo"].each { |x|
    context "with manage => #{x}" do
      let(:params) { { :manage => x } }
      it do
        expect {
          should compile
	  should contain_class('splunk::config::install::group')
        } #.to raise_error(Puppet::Error, /manage must be one of undef, true, false, yes, or no/)
      end
    end
  }

  #ensure
  ['present', 'absent', 'role'].each { |x|
    context "with ensure => #{x}" do
    let(:params) { { :ensure => x } }
      it do
        expect {
          should contain_class('splunk::config::install::group')
	}
      end
    end
  }

  ["foo"].each { |x|
    context "with ensure => #{x}" do
    let(:params) { { :ensure => x } }
      it do
        expect {
	  should contain_class('splunk::config::install::group')
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
          should contain_class('splunk::config::install::group')
	}
      end
    end
  }

  ["foo"].each { |x|
    context "with system => #{x}" do
      let(:params) { { :system => x } }
      it do
        expect {
          should contain_class('splunk::config::install::group')
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
          should contain_class('splunk::config::install::group')
	}
      end
    end
  }

  context 'with forcelocal => foo' do
    let(:params) { {:forcelocal => 'foo'} }
    it do
      expect {
        should contain_class('splunk::config::install::group')
      }.to raise_error(Puppet::Error, /forcelocal must be true, false, yes, or no/)
    end
  end

end
