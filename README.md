# A Virtual Machine for Rails applications development

## Introduction

This project automates the setup of a development environment for
working on Rails applications.

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)
    >= 1.1.2 required

* [ssh-copy-id](http://linux.die.net/man/1/ssh-copy-id)

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone https://github.com/av-ast/rails-dev-box.git
    host $ rails-dev-box
    host $ bundle install
    host $ cd vagrant/rails-dev-box
    host $ bundle install
    host $ berks --path ../../cookbooks
    host $ vagrant up
    host $ ssh-copy-id vagrant@10.0.1.13
    host $ cd ../../
    host $ knife solo cook vagrant@10.0.1.13 nodes/rails-dev-box.rb

That's it.

If the base box is not present that command fetches it first. 
If during the installation you will be asked to enter the password for
vagrant user, just enter `vagrant`.
After the installation has finished, you can access the virtual machine with

    host $ cd vagrant/rails-dev-box
    host $ vagrant ssh
    ...
    vagrant@rails-dev-box:~$

## What's In The Box

* rbenv 0.4.0

* Ruby 1.9.3

* Bundler 1.3.5

* Postgresql 9.2

* Redis server 2.2.12

* Elasticsearch 0.20.6

## Recommended Workflow

The recommended workflow is

* edit in the host computer and

* test and run application within the virtual machine.

Put project you are working on inside your host home directory.
Vagrant mounts your home directory (via NFS) as `/home_dir` within the virtual machine:

    vagrant@rails-dev-box:~$ ls /home_dir

so we are ready to go to edit in the host, and test in the virtual machine.

This workflow is convenient because in the host computer you normally have your
editor of choice fine-tuned, Git configured, and SSH keys in place.

## Virtual Machine Management

When done just log out with `^D` and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://vagrantup.com/v2/docs/index.html) for more information on Vagrant.
