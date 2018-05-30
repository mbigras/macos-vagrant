# macOS Vagrant

> Hacking on the jhcook/macos-sierra Vagrant box

## Usage

```
git clone https://github.com/mbigras/macos-vagrant
cd macos-vagrant
vagrant up
vagrant ssh
cd playbook
./bootstrap.sh
```

## Notes

Using NFS the /etc/sudoers file needs to be edited using `sudo visudo`

Careful it is possible to lock yourself out if your username isn't added along with the `admin` group.

```
Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
Cmnd_Alias VAGRANT_NFSD = /sbin/nfsd restart
Cmnd_Alias VAGRANT_EXPORTS_REMOVE = /usr/bin/sed -E -e /*/ d -ibak /etc/exports
%admin ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD, VAGRANT_EXPORTS_REMOVE
max ALL=NOPASSWD: ALL
```

I experienced an error while using the [jhcook/macos-sierra](https://app.vagrantup.com/jhcook/boxes/macos-sierra) box.

```
==> default: Booting VM...
There was an error while executing `VBoxManage`, a CLI used by Vagrant
for controlling VirtualBox. The command and stderr is shown below.

Command: ["startvm", "b8a680e3-383b-44be-be74-8e914a8fb7e5", "--type", "headless"]

Stderr: VBoxManage: error: Implementation of the USB 2.0 controller not found!
VBoxManage: error: Because the USB 2.0 controller state is part of the saved VM state, the VM cannot be started. To fix this problem, either install the 'Oracle VM VirtualBox Extension Pack' or disable USB 2.0 support in the VM settings.
VBoxManage: error: Note! This error could also mean that an incompatible version of the 'Oracle VM VirtualBox Extension Pack' is installed (VERR_NOT_FOUND)
VBoxManage: error: Details: code NS_ERROR_FAILURE (0x80004005), component ConsoleWrap, interface IConsole
```

You can manually disable USB via VirtualBox but that customization can also be made via the Vagrantfile. Details discussed at:

https://github.com/jonschipp/vagrant/issues/3#issuecomment-138215720

```
Vagrant.configure("2") do |config|
  config.vm.box = "jhcook/macos-sierra"
  # https://github.com/jonschipp/vagrant/issues/3#issuecomment-138215720
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
  end
end
```