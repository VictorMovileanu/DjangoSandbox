export DEBIAN_FRONTEND=noninteractive

sudo apt-get update

### PostgreSQL
sudo apt-get -y install postgresql postgresql-contrib
sudo -u postgres createuser $POSTGRES_USER_NAME
sudo -u postgres createdb $POSTGRES_DB_NAME --owner $POSTGRES_USER_NAME
sudo -u postgres psql -c "ALTER USER $POSTGRES_USER_NAME WITH PASSWORD '$POSTGRES_USER_PASSWORD'"
sudo -u postgres psql -c "ALTER USER $POSTGRES_USER_NAME CREATEDB;" # allow user to create test databases


### PIP
sudo apt-get -y install python3-pip libpq-dev
pip3 install -r /home/vagrant/project/requirements.txt
update-alternatives --install /usr/bin/python python /usr/bin/python3 10


### Celery
# Installation instructions:
# - https://www.vultr.com/docs/how-to-install-rabbitmq-on-ubuntu-16-04-47
# - https://docs.celeryproject.org/en/latest/getting-started/brokers/rabbitmq.html
sudo apt-get -y install rabbitmq-server
sudo rabbitmqctl add_user $RABBIT_USER_NAME $RABBIT_USER_PASSWORD
sudo rabbitmqctl add_vhost $RABBIT_VHOST
sudo rabbitmqctl set_permissions -p $RABBIT_VHOST $RABBIT_USER_NAME ".*" ".*" ".*"


### Redis
sudo apt-get -y install redis-server
sudo systemctl enable redis-server.service
