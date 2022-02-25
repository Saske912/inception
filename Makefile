NAME=inception
${NAME}:
	./srcs/vagrant.sh

all: ${NAME}

clean:
	cd srcs && vagrant ssh -c /vagrant/tools/clean.sh

fclean:
	cd srcs && vagrant destroy

start:
	cd srcs && vagrant resume

stop:
	cd srcs && vagrant halt

test:
	 cd srcs && vagrant ssh -c /vagrant/tools/tests.sh

fast:
	cd srcs && vagrant ssh -c /vagrant/start.sh

re: fclean all