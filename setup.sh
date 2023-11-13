#!/bin/bash

# Update and install necessary packages
sudo apt-get update
sudo apt-get install -y vim zsh git openssh-server npm curl daemonize dbus-user-session fontconfig

# Install specific versions or packages from URLs
sudo apt-get install -y fc-cache fonts-powerline fonts-hack-ttf
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
sudo tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb

# Configure PATH
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
echo 'export PATH=$PATH:/home/giladl/go/bin' >> ~/.profile
echo 'export PATH=$PATH:/home/giladl/.local/bin' >> ~/.profile
source ~/.profile

# Clone and install Powerline Fonts
git clone https://github.com/powerline/fonts.git
(cd fonts && ./install.sh)

# SSH server configuration
sudo sed -i -E 's,^#?Port.*$,Port 2022,' /etc/ssh/sshd_config
echo '${USER} ALL=(root) NOPASSWD: /usr/sbin/service ssh start' | sudo tee /etc/sudoers.d/service-ssh-start
sudo service ssh restart

# FZF installation
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Neovim installation
mv /mnt/c/Users/Gilad/Downloads/nvim-linux64.deb /tmp
sudo apt install /tmp/nvim-linux64.deb

# Systemd namespace scripts
echo 'source /usr/sbin/start-systemd-namespace' | sudo tee -a /etc/bash.bashrc
sudo cp /path/to/start-systemd-namespace /usr/sbin/
sudo cp /path/to/enter-systemd-namespace /usr/sbin/
sudo chmod +x /usr/sbin/enter-systemd-namespace

# Additional configurations
echo 'additional configurations here' >> ~/.bashrc
echo 'additional configurations here' >> ~/.zshrc

# Create projects directory
mkdir ~/projects

# Cleanup
sudo apt-get autoremove -y