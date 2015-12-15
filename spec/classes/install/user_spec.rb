
require 'spec_helper'

describe 'splunk::install::user' do
  
  it { should compile }

  context 'with defaults for all parameters' do
    it { 
			should contain_class('splunk::install::user')
	    should contain_user('splunk').with({
        'ensure'           => 'present',
	      'system'           => true,
	      'comment'          => 'Splunk Server',
	      'expiry'           => 'absent',
		    'forcelocal'       => nil,
		    'groups'           => [],
		    'gid'              => '',
		    'home'             => nil,
		    'password'         => '!!',
		    'password_max_age' => nil,
		    'password_min_age' => nil,
		    'shell'            => '/sbin/nologin',
		    'purge_ssh_keys'   => false,
		    'uid'              => nil,
	    }) 
    }
  end

  # manage
  [true, "yes", nil].each { |x|
    context "with manage => #{x}" do
      let(:params) { { :manage => x } }
      it { 
	      should contain_user('splunk').with({
          'ensure'           => 'present',
	        'system'           => true,
          'comment'          => 'Splunk Server',
          'expiry'           => 'absent',
	        'forcelocal'       => nil,
	        'groups'           => [],
		      'gid'              => '',
		      'home'             => nil,
		      'password'         => '!!',
		      'password_max_age' => nil,
		      'password_min_age' => nil,
		      'shell'            => '/sbin/nologin',
		      'purge_ssh_keys'   => false,
		      'uid'              => nil,
	      }) 
      }
    end
  }
  
  # user
  ["splunk2", "apache", "logreader"].each { |x|
     context "with user => #{x}" do
       let(:params) { { :user => x } }
       it { 
	       should contain_user(x).with({
          'ensure'           => 'present',
	        'system'           => true,
	        'comment'          => 'Splunk Server',
	        'expiry'           => 'absent',
		      'forcelocal'       => nil,
		      'groups'           => [],
		      'gid'              => '',
		      'home'             => nil,
		      'password'         => '!!',
		      'password_max_age' => nil,
		      'password_min_age' => nil,
		      'shell'            => '/sbin/nologin',
		      'purge_ssh_keys'   => false,
		      'uid'              => nil,
	      }) 
      }
    end
  }

  #	#ensure
  ['present', 'absent', 'role'].each { |x|
		context "with ensure => #{x}" do
			let(:params) { { :ensure => x } }
      it { 
	      should contain_user('splunk').with({
          'ensure'           => x,
	        'system'           => true,
	        'comment'          => 'Splunk Server',
	        'expiry'           => 'absent',
		      'forcelocal'       => nil,
		      'groups'           => [],
		      'gid'              => '',
		      'home'             => nil,
		      'password'         => '!!',
		      'password_max_age' => nil,
		      'password_min_age' => nil,
		      'shell'            => '/sbin/nologin',
		      'purge_ssh_keys'   => false,
		      'uid'              => nil,
	      }) 
      }
    end
  }

  #system
  [true, false, "yes", "no"].each { |x|
    context "with system => #{x}" do
      let(:params) { { :system => x } }
      it {
 	      should contain_user('splunk').with({
          'ensure'           => 'present',
 	        'system'           => x,
 	        'comment'          => 'Splunk Server',
 	        'expiry'           => 'absent',
 		      'forcelocal'       => nil,
 		      'groups'           => [],
 		      'gid'              => '',
 		      'home'             => nil,
 		      'password'         => '!!',
 		      'password_max_age' => nil,
 		      'password_min_age' => nil,
 		      'shell'            => '/sbin/nologin',
 		      'purge_ssh_keys'   => false,
 		      'uid'              => nil,
 	      }) 
      }
    end
  }

 	#comment
  ["foobarbaz","Splunker","foobizbar"].each { |x|
    context "with comment => #{x}" do
      let(:params) { { :comment => x } }
      it { 
	      should contain_user('splunk').with({
          'ensure'           => 'present',
	        'system'           => true,
	        'comment'          => x,
	        'expiry'           => 'absent',
		      'forcelocal'       => nil,
		      'groups'           => [],
		      'gid'              => '',
		      'home'             => nil,
		      'password'         => '!!',
		      'password_max_age' => nil,
		      'password_min_age' => nil,
		      'shell'            => '/sbin/nologin',
		      'purge_ssh_keys'   => false,
		      'uid'              => nil,
	      }) 
      }
    end
  }

 	 #expiry
   ['absent', '2015-01-01', '2020-02-28'].each { |x|
     context "with expiry => #{x}" do
       let(:params) { { :expiry => x } }
       it { 
 	      should contain_user('splunk').with({
           'ensure'           =>'present',
 	        'system'           => true,
 	        'comment'          => 'Splunk Server',
	        'expiry'           => x,
 		      'forcelocal'       => nil,
 		      'groups'           => [],
 		      'gid'              => '',
 		      'home'             => nil,
 		      'password'         => '!!',
 		      'password_max_age' => nil,
 		      'password_min_age' => nil,
 		      'shell'            => '/sbin/nologin',
 		      'purge_ssh_keys'   => false,
		      'uid'              => nil,
	      }) 
      }
    end
  }

  #forcelocal
  [true, false, "yes", "no"].each { |x|
    context "with forcelocal => #{x}" do
      let(:params) { { :forcelocal => x } }
      it { 
	      should contain_user('splunk').with({
          'ensure'           =>'present',
	        'system'           => true,
	        'comment'          => 'Splunk Server',
	        'expiry'           => 'absent',
		      'forcelocal'       => x,
		      'groups'           => [],
		      'gid'              => '',
		      'home'             => nil,
		      'password'         => '!!',
		      'password_max_age' => nil,
		      'password_min_age' => nil,
		      'shell'            => '/sbin/nologin',
		      'purge_ssh_keys'   => false,
		      'uid'              => nil,
	      }) 
      }
    end
  }

	#groups
  [[], ["foo", "bar"], [1, 333], ["splunk"], ["splunk", "logreader"], ["splunk", "logreader", 3]].each { |x|
    context "with groups => #{x}" do
      let(:params) { { :groups => x } }
      it { 
	      should contain_user('splunk').with({
          'ensure'           =>'present',
	        'system'           => true,
	        'comment'          => 'Splunk Server',
	        'expiry'           => 'absent',
		      'forcelocal'       => nil,
		      'groups'           => x,
		      'gid'              => '',
		      'home'             => nil,
		      'password'         => '!!',
		      'password_max_age' => nil,
		      'password_min_age' => nil,
		      'shell'            => '/sbin/nologin',
		      'purge_ssh_keys'   => false,
		      'uid'              => nil,
	      }) 
      }
    end
  }

  #	gid
	#	TODO: nil case
  [102, 103].each { |x|
    context "with gid => #{x}" do
      let(:params) { { :gid => x } }
      it { 
	      should contain_user('splunk').with({
          'ensure'           => 'present',
	        'system'           => true,
	        'comment'          => 'Splunk Server',
	        'expiry'           => 'absent',
		      'forcelocal'       => nil,
		      'groups'           => [],
		      'gid'              => x,
		      'home'             => nil,
		      'password'         => '!!',
		      'password_max_age' => nil,
		      'password_min_age' => nil,
		      'shell'            => '/sbin/nologin',
		      'purge_ssh_keys'   => false,
		      'uid'              => nil,
	      }) 
      }
    end
  }

	#home
	# TODO: nil case
  ["/home/splunk", "/opt/splunk"].each { |x|
    context "with home => #{x}" do
      let(:params) { { :home => x } }
      it { 
	      should contain_user('splunk').with({
          'ensure'           =>'present',
	        'system'           => true,
	        'comment'          => 'Splunk Server',
	        'expiry'           => 'absent',
		      'forcelocal'       => nil,
		      'groups'           => [],
		      'gid'              => '',
		      'home'             => x,
		      'password'         => '!!',
		      'password_max_age' => nil,
		      'password_min_age' => nil,
		      'shell'            => '/sbin/nologin',
		      'purge_ssh_keys'   => false,
		      'uid'              => nil,
	      }) 
      }
    end
  }

  #password
  ["", "!!", "ALDSLKJDSLKJS"].each { |x|
    context "with password => #{x}" do
      let(:params) { { :password => x } }
      it { 
	      should contain_user('splunk').with({
          'ensure'           =>'present',
	        'system'           => true,
	        'comment'          => 'Splunk Server',
	        'expiry'           => 'absent',
		      'forcelocal'       => nil,
	      'groups'           => [],
		      'gid'              => '',
		      'home'             => nil,
		      'password'         => x,
		      'password_max_age' => nil,
		      'password_min_age' => nil,
		      'shell'            => '/sbin/nologin',
		      'purge_ssh_keys'   => false,
		      'uid'              => nil,
	      }) 
      }
    end
  }

#	#password_max_age
#  [true, "yes", :absent].each { |x|
#    context "with manage => #{x}" do
#      let(:params) { { :manage => x } }
#      it { 
#	      should contain_user('splunk').with({
#	        'manage'           => x,
#	        'user'             => 'splunk',
#          'ensure'           =>'present',
#	        'system'           => true,
#	        'comment'          => 'Splunk Server',
#	        'expiry'           => 'absent',
#		      'forcelocal'       => nil,
#		      'groups'           => [],
#		      'gid'              => '',
#		      'home'             => nil,
#		      'password'         => '!!',
#		      'password_max_age' => nil,
#		      'password_min_age' => nil,
#		      'shell'            => '/sbin/nologin',
#		      'purge_ssh_keys'   => false,
#		      'uid'              => nil,
#	      }) 
#      }
#    end
#  }
#
#	#password_min_age
#  [true, "yes", :absent].each { |x|
#    context "with manage => #{x}" do
#      let(:params) { { :manage => x } }
#      it { 
#	      should contain_user('splunk').with({
#	        'manage'           => x,
#	        'user'             => 'splunk',
#          'ensure'           =>'present',
#	        'system'           => true,
#	        'comment'          => 'Splunk Server',
#	        'expiry'           => 'absent',
#		      'forcelocal'       => nil,
#		      'groups'           => [],
#		      'gid'              => '',
#		      'home'             => nil,
#		      'password'         => '!!',
#		      'password_max_age' => nil,
#		      'password_min_age' => nil,
#		      'shell'            => '/sbin/nologin',
#		      'purge_ssh_keys'   => false,
#		      'uid'              => nil,
#	      }) 
#      }
#    end
#  }
#
#	#shell
#  [true, "yes", :absent].each { |x|
#    context "with manage => #{x}" do
#      let(:params) { { :manage => x } }
#      it { 
#	      should contain_user('splunk').with({
#	        'manage'           => x,
#	        'user'             => 'splunk',
#          'ensure'           =>'present',
#	        'system'           => true,
#	        'comment'          => 'Splunk Server',
#	        'expiry'           => 'absent',
#		      'forcelocal'       => nil,
#		      'groups'           => [],
#		      'gid'              => '',
#		      'home'             => nil,
#		      'password'         => '!!',
#		      'password_max_age' => nil,
#		      'password_min_age' => nil,
#		      'shell'            => '/sbin/nologin',
#		      'purge_ssh_keys'   => false,
#		      'uid'              => nil,
#	      }) 
#      }
#    end
#  }
#
#	#purge_ssh_keys
#  [true, "yes", :absent].each { |x|
#    context "with manage => #{x}" do
#      let(:params) { { :manage => x } }
#      it { 
#	      should contain_user('splunk').with({
#	        'manage'           => x,
#	        'user'             => 'splunk',
#          'ensure'           =>'present',
#	        'system'           => true,
#	        'comment'          => 'Splunk Server',
#	        'expiry'           => 'absent',
#		      'forcelocal'       => nil,
#		      'groups'           => [],
#		      'gid'              => '',
#		      'home'             => nil,
#		      'password'         => '!!',
#		      'password_max_age' => nil,
#		      'password_min_age' => nil,
#		      'shell'            => '/sbin/nologin',
#		      'purge_ssh_keys'   => false,
#		      'uid'              => nil,
#	      }) 
#      }
#    end
#  }
#
#	#uid
#  [true, "yes", :absent].each { |x|
#    context "with manage => #{x}" do
#      let(:params) { { :manage => x } }
#      it { 
#	      should contain_user('splunk').with({
#	        'manage'           => x,
#	        'user'             => 'splunk',
#          'ensure'           =>'present',
#	        'system'           => true,
#	        'comment'          => 'Splunk Server',
#	        'expiry'           => 'absent',
#		      'forcelocal'       => nil,
#		      'groups'           => [],
#		      'gid'              => '',
#		      'home'             => nil,
#		      'password'         => '!!',
#		      'password_max_age' => nil,
#		      'password_min_age' => nil,
#		      'shell'            => '/sbin/nologin',
#		      'purge_ssh_keys'   => false,
#		      'uid'              => nil,
#	      }) 
#      }
#    end
#  }
#	
#  # false, no
#  [false, "no"].each { |x|
#    context "with manage => #{x}" do
#      let(:params) { { :manage => x } }
#      it {
#	      should contain_class('splunk::config::install::user')
#	      should not_contain_user('splunk')
#      }
#    end
#  }

end
