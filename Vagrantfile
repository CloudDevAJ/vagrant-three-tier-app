Vagrant.configure("2") do |config|

  #base box used for all 3 VMs
  config.vm.box = "hashicorp/bionic64"

  #-------Web server--------#
  config.vm.define "web" do |web|
    web.vm.hostname = "web-server"

    web.vm.network "private_network",
      ip: "192.168.56.10"

    web.vm.network "forwarded_port",
      guest: 80,
      host: 8080,
      auto_correct: true

    web.vm.provider "virtualbox" do |vb|
      vb.name = "WebServer"
      vb.memory = 2048
      vb.cpus = 2
    end

    web.vm.provision "shell", 
    path: "scripts/web.sh"
  end

  #-------App server--------#
  config.vm.define "app" do |app|
    app.vm.hostname = "app-server"

    app.vm.network "private_network",
      ip: "192.168.56.11"


    app.vm.provider "virtualbox" do |vb|
      vb.name = "AppServer"
      vb.memory = 2048
      vb.cpus = 2
    end

    app.vm.provision "shell", 
    path: "scripts/app.sh"
  end

  #-------DB server--------#
  config.vm.define "db" do |db|
    db.vm.hostname = "db-server"

    db.vm.network "private_network",
      ip: "192.168.56.12"


    db.vm.provider "virtualbox" do |vb|
      vb.name = "DBServer"
      vb.memory = 2048
      vb.cpus = 2
    end

    db.vm.provision "shell", 
    path: "scripts/db.sh"
  end

end
