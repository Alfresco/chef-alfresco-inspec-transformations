transformations = node.content['transformations']

libreofficeusr = transformations['libreoffice']['libreoffice_user']
tomcatusr = transformations['libreoffice']['tomcat_user']
temp_folder = transformations['libreoffice']['temp_folder']
libreofficeversion = transformations['libreoffice']['version']

control 'Libreoffice installation' do
  impact 1.0
  desc 'Check Libreoffice Installation'

  describe user(libreofficeusr) do
    it { should exist }
    its('groups') { should eq [libreofficeusr, tomcatusr] }
  end

  describe group(libreofficeusr) do
    it { should exist }
  end

  describe user(tomcatusr) do
    it { should exist }
  end

  describe group(tomcatusr) do
    it { should exist }
  end

  describe directory('/opt/libreoffice5.2/') do
    it { should exist }
    it { should be_owned_by libreofficeusr }
    it { should be_directory }
    its('mode') { should cmp '0755' }
    its('group') { should eq tomcatusr }
  end

  describe command('/opt/libreoffice5.2/program/soffice.bin --version') do
    its(:stdout) { should include("LibreOffice #{libreofficeversion}") }
  end

  describe file('/opt/libreoffice') do
    it { should be_symlink }
    it { should exist }
    it { should be_linked_to '/opt/libreoffice5.2' }
    it { should be_owned_by libreofficeusr }
    its('mode') { should cmp '0755' }
    its('group') { should eq tomcatusr }
  end

  describe file('/opt/libreoffice5.2/program/soffice.bin') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by libreofficeusr }
    its('group') { should eq tomcatusr }
    its('mode') { should cmp '0755' }
  end

  describe file('/opt/libreoffice5.2/program/.soffice.bin') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by libreofficeusr }
    its('group') { should eq tomcatusr }
    its('mode') { should cmp '0755' }
  end

  describe directory(temp_folder) do
    it { should exist }
    it { should be_owned_by tomcatusr }
    it { should be_directory }
    its('mode') { should cmp '02755' }
    its('group') { should eq tomcatusr }
  end

  describe file('/etc/sudoers.d/libreoffice') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0440' }
    its('content') { should match %r{#{tomcatusr} ALL=\(#{libreofficeusr}\) NOPASSWD:\/opt\/libreoffice5\.2\/program\/\.soffice\.bin} }
  end
end
