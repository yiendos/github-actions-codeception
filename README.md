# github-actions-codeception

cd yiendos 

docker build --no-cache -t yiendos/nginx:local .

docker build --no-cache -t actions/codeception:local .

docker-compose up --detach

docker-compose exec demo /bin/sh -c "/usr/local/bin/bootstrap.sh"

to run on github actions
docker-compose run demo "/usr/local/bin/bootstrap.sh"

#after downloading joomla tar locally, extract so as to a have a good folder name 
mkdir joomla && tar xf testing.tar -C joomla --strip-components 1


#how to run install database after compose up 
docker-compose run demo "/usr/local/bin/bootstrap.sh"

#alternative would be to add a sleep to the install-database.sh so as to hopefully allow db to exist by then 

#Copy an updated file to docker

docker cp docker/scripts/install-database.sh cbf758d69b85:/usr/local/bin/install-database.sh
