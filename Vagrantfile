 # vi: set ft=ruby :

 distros = [
   {
     :distro => "archlinux",
     :box => "archlinux/archlinux",
     :install_ansible => "pacman -Syu --noconfirm && pacman -S ansible --noconfirm"
   },
   {
     :distro => "opensuse",
     :box => "opensuse/Tumbleweed.x86_64",
     :install_ansible => "zypper --non-interactive dup && zypper --non-interactive install ansible"
   },
   {
     :distro => "fedora",
     :box => "onlyoffice/base-fedora42",
     :install_ansible => "dnf update -y && dnf install -y ansible"
   },
   {
     :distro => "debian",
     :box => "generic-x64/debian12",
     :install_ansible => "apt update -y && apt upgrade -y && apt install -y ansible"
   },
   {
     :distro => "ubuntu",
     :box => "bento/ubuntu-24.04",
     :install_ansible => "apt update -y && apt upgrade -y && apt install -y ansible"
   },
 ]

Vagrant.configure("2") do |config|
  config.vm.synced_folder "./", "/home/vagrant/kale"

  config.ssh.insert_key = false
  config.ssh.forward_agent = true

   distros.each do |conf|
     config.vm.define conf[:distro] do |node|
       node.vm.box = conf[:box]
       node.vm.hostname = "kale-#{conf[:hostname]}"

       node.vm.provider "virtualbox" do |vb|
         vb.memory = "8192"
         vb.cpus = 4
       end


     node.vm.provision "shell", name: "install-ansible", inline: conf[:install_ansible]
     end
   end
end
