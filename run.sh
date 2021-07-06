sudo echo "Running Linux Setup"
sudo apt-get install ansible -y
ansible-galaxy install hurricanehrndz.rustup
ansible-playbook --connection=local --inventory 127.0.0.1, main.yaml
