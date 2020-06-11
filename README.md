# github-actions-codeception

docker build --no-cache -t actions/codeception:local .

docker-compose up --detach

docker-compose exec demo /bin/sh -c "/usr/local/bin/bootstrap.sh"