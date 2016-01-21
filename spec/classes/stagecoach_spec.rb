require 'spec_helper'

supported_oses = {}.merge!(on_supported_os)
RspecPuppetFacts.meta_supported_os.each do |os|
  if os['operatingsystem'] =~ /windows/i
    os['operatingsystemrelease'].each do |release|
      os_string = "#{os['operatingsystem']}-#{release}"
      supported_oses[os_string] = {
        :operatingsystem => 'windows',
        :kernelversion => '6.3.9600', # Just defaulting to 2012r2
      }
    end
  end
end

describe 'stagecoach' do
  context 'supported operating systems' do
    supported_oses.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 'stagecoach class without any parameters' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('stagecoach') }
          it { is_expected.to contain_class('stagecoach::params') }
          it { is_expected.to contain_class('stagecoach::install').that_comes_before('stagecoach::config') }
          it { is_expected.to contain_class('stagecoach::config') }

          describe 'stagecoach::install' do
            it { is_expected.to contain_file('/opt/stagecoach').with({:owner => 'stagecoach'}) }
            it { is_expected.to contain_vcsrepo('/opt/stagecoach') }
            it { is_expected.to contain_file('/etc/profile.d/stagecoach.sh') }
            it { is_expected.to contain_user('stagecoach')}
          end
          describe 'stagecoach::config' do
            it { is_expected.to contain_file('/opt/stagecoach/settings') }
            it { is_expected.to contain_file('/opt/stagecoach/apps').with({'ensure' => 'directory'}) }
          end
        end
        context 'stagecoach class with user management disabled' do
          let(:params) do
            {
              :manage_user => false
            }
          end
          describe 'stagecoach::install' do
            it { is_expected.not_to contain_user('stagecoach')}
          end
        end
      end
    end
  end

  # context 'unsupported operating system' do
  #   describe 'stagecoach class without any parameters on Solaris/Nexenta' do
  #     let(:facts) do
  #       {
  #         :osfamily        => 'Solaris',
  #         :operatingsystem => 'Nexenta',
  #       }
  #     end

  #     it { expect { is_expected.to contain_class('stagecoach') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
  #   end
  # end
end
