pre:
* get a ubuntu:latest instance
* install redis && libvips
* make redis run in daemonized mode
* install gem

cmd:
* sudo ansible-playbook site.yaml
* sudo systemctl restart apache2
* sudo a2enmod rewrite && sudo service apache2 restart

post:
* you now configured an apache2 server that we'll use a reverse proxy
* ./bin/rails server


refs:
* https://github.com/jacobemery/linux1-ansible-lab/tree/general
* rails docs
