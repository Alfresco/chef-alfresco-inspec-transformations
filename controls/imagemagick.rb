transformations = node.content['transformations']
imagemagickversion = transformations['imagemagick']['version']
link_config = transformations['imagemagick']['link_config']
link_modules = transformations['imagemagick']['link_modules']
install_imagemagick = transformations['install_imagemagick']
use_im_os_repo = transformations['imagemagick']['use_im_os_repo']

control 'ImageMagick installation' do
  impact 1.0
  desc 'ImageMagick installation'
  only_if { install_imagemagick }

  describe file('/usr/bin/convert') do
    it { should exist }
  end

  describe command('/usr/bin/convert --version') do
    its(:stdout) { should include("Version: ImageMagick #{imagemagickversion}") } unless use_im_os_repo
    its(:exit_status) { should eq 0 }
  end

  describe command('yum list installed imagemagick* --quiet | grep ImageMagick.x86_64') do
    its(:stdout) { should include(imagemagickversion) } unless use_im_os_repo
    its(:exit_status) { should eq 0 }
  end

  unless use_im_os_repo
    describe command('yum list installed imagemagick* --quiet | grep ImageMagick-libs.x86_64') do
      its(:stdout) { should include(imagemagickversion) }
      its(:exit_status) { should eq 0 }
    end
  end

  describe file(link_config) do
    it { should be_symlink }
    it { should exist }
  end

  describe file(link_modules) do
    it { should be_symlink }
    it { should exist }
  end
end
