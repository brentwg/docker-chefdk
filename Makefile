IMAGE_VERSION = 0.0.5

.PHONY: build
build: 
	docker build -t docker-chefdk:$(IMAGE_VERSION) . \
		--build-arg USER=$(USER) \
		--build-arg USERID=`id -u` \
		--build-arg DOCKERGID=`getent group docker | awk -F: '{print $$3}'`

.PHONY: run
run:
	docker run -it \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(HOME)/Projects/chef/cookbooks:$(HOME)/cookbooks:z \
		-v $(HOME)/.gitconfig:$(HOME)/.gitconfig \
		--name $(USER)_chefdk \
		docker-chefdk:$(IMAGE_VERSION)

.PHONY: test
test:
	docker run --rm -it \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(HOME)/Projects/chef/cookbooks:$(HOME)/cookbooks:z \
		-v $(HOME)/.gitconfig:$(HOME)/.gitconfig \
		--name $(USER)_chefdk-test \
		docker-chefdk:$(IMAGE_VERSION) \
		chef --version

.PHONY: clean
clean:
	- docker rm $(USER)_chefdk
	- docker rmi docker-chefdk:$(IMAGE_VERSION)
