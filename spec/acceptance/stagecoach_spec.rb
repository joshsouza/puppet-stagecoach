require 'spec_helper_acceptance'

describe 'stagecoach class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      package{'git': ensure => present } ->
      class { 'stagecoach':
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe user('stagecoach') do
      it { is_expected.to exist }
    end

    describe file('/opt/stagecoach') do
      it { is_expected.to be_directory }
      it { is_expected.to be_owned_by 'stagecoach' }
    end

    describe file('/opt/stagecoach/settings') do
      it { is_expected.to be_file }
      its(:content) { should match /DIR=\/opt\/stagecoach/ }
      it { is_expected.to be_owned_by 'stagecoach' }
    end

    describe file('/etc/profile.d/stagecoach.sh') do
      it { is_expected.to be_file }
      its(:content) { should match "export PATH=${PATH}:/opt/stagecoach/bin" }
    end

    describe file('/opt/stagecoach/.git') do
      it { is_expected.to be_directory }
      it { is_expected.to be_owned_by 'stagecoach' }
    end

    describe file('/opt/stagecoach/apps') do
      it { is_expected.to be_directory }
      it { is_expected.to be_owned_by 'stagecoach' }
    end
  end
end
