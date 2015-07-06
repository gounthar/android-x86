# -*- coding: utf-8 -*-
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"

   config.vm.provider "virtualbox" do |vb|
     vb.gui = false
   end
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  #config.vm.box = "hashicorp/precise64"
  config.vm.box = "chef/ubuntu-14.04"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.

  # Autres plages
#config.vm.network "private_network", ip: "192.168.200.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
#config.vm.network "public_network"


  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
config.vm.provision "shell", inline: <<-SHELL
sudo apt-get update
sudo apt-get install -y python-software-properties 
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:webupd8team/java
sudo add-apt-repository "deb http://archive.canonical.com/ trusty partner"
sudo apt-get update
#sudo apt-get upgrade -y
echo "[vagrant provisioning] Checking if the box was already provisioned..."
if [ -e "/home/vagrant/.provision_java_check" ]
then
  echo "[vagrant provisioning] The box is already provisioned..."
  exit
fi
echo "[vagrant provisioning] Updating mirrors in sources.list"
sudo sed -i -e '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse\ndeb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse\ndeb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse\ndeb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse\n' /etc/apt/sources.list
sudo apt-get update
echo "[vagrant provisioning] Installing Java..."
sudo apt-get -y install python-software-properties
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true | sudo /usr/bin/debconf-set-selections
sudo apt-get -y install oracle-java7-set-default
sudo apt-get -y install oracle-java8-set-default
sudo apt-get -y install oracle-java6-set-default
#sudo update-java-alternatives -s java-1.6.0-openjdk
export JAVA_HOME="/usr/lib/jvm/java-6-oracle/jre"
export PATH=$JAVA_HOME/bin:$PATH
export USE_CCACHE=1
echo "[vagrant provisioning] Java installed"
sudo dpkg --configure -a
apt-get autoremove -y
echo "[vagrant provisioning] Creating .provision_java_check file..."
touch .provision_java_check
sudo apt-get install -y connect-proxy socat zip build-essential curl git-core
sudo mkdir -p /home/vagrant/bin
PATH=~/bin:$PATH
sudo curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /home/vagrant/bin/repo
sudo chmod a+x  /home/vagrant/bin/repo
export M3_HOME=”/usr/share/maven3″
export MAVEN_HOME=”/usr/share/maven3″
export M3=”/usr/share/maven3/bin”
export M2_HOME=”/usr/share/maven3″
export M2=”/usr/share/maven3/bin”
sudo apt-get install -y python gcc patch flex bison gperf g++ squashfs-tools g++-multilib zlib1g-dev lib32z1-dev lib32ncurses5-dev gcc-multilib libwxgtk2.8-dev tofrodos texinfo mtools lib32z1 lib32ncurses5 lib32bz2-1.0 gnupg flex bison gperf build-essential \
zlib1g-dev libc6-dev lib32ncurses5-dev \
x11proto-core-dev libx11-dev lib32readline-gplv2-dev lib32z-dev \
libgl1-mesa-dev g++-multilib mingw-w64 python-markdown \
libxml2-utils xsltproc yasm g++-4.4-multilib ccache bc expect
sudo mkdir /home/vagrant/android-x86
sudo chmod 777 /home/vagrant/android-x86
cd /home/vagrant/android-x86
expect -c '
set timeout -1   ;
spawn sudo /home/vagrant/bin/repo init -u http://git.android-x86.org/manifest -b kitkat-x86;
expect { 
    "Your Name" { exp_send "\r" ; exp_continue }
    "Your Email" { exp_send "\r" ; exp_continue }
    "is this correct" { exp_send "Y\r" ; exp_continue }
    "Enable color display in this user account"  { exp_send "Y\r" ; exp_continue }
    eof
}
'
sudo chown -R vagrant:vagrant /home/vagrant/
SHELL
end
