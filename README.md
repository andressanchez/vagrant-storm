# vagrant-storm

vagrant-storm provides a multi-VM [Storm](http://storm.incubator.apache.org) deployment using [Vagrant](http://vagrantup.com).

## Dependencies

* Vagrant
* VirtualBox
* librarian

## Usage

    $ git clone git://github.com/andressanchez/vagrant-storm.git
    $ cd vagrant-storm/vagrant
    $ librarian-chef install
    $ cd ..
    $ vagrant up
    
After that, we have the following VMs:

	$ vagrant status
	Current machine states:

	zookeeper                 running (virtualbox)
	nimbus                    running (virtualbox)
	supervisor1               running (virtualbox)
	supervisor2               running (virtualbox)

To access a particular VM, open a command-line prompt and enter:

    $ vagrant ssh nimbus
    Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic x86_64)

	* Documentation:  https://help.ubuntu.com/
	Welcome to your Vagrant-built virtual machine.
	Last login: Wed Jul  2 21:38:34 2014 from 10.0.2.2
	vagrant@nimbus:~$
    
## Check installation

Open your browser and enter the following URL:

	http://localhost:8080/index.html
	
If everything went well, we should see something like this:

![alt tag](http://www.michael-noll.com/blog/uploads/Storm-ui-screenshot-0.8.2.png)

