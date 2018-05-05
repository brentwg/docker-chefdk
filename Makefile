.PHONY: build-chefdk
build-chefdk: 
	docker build -t docker-chefdk . \
		--build-arg USER=$(USER) \
		--build-arg DOCKERGID=`getent group docker | awk -F: '{print $$3}'`

.PHONY: run-chefdk
run-chefdk:
	docker run -it \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(HOME)/Projects/chef/cookbooks:$(HOME)/cookbooks:z \
		-v $(HOME)/.gitconfig:$(HOME)/.gitconfig \
		--name $(USER)_chefdk \
		docker-chefdk
