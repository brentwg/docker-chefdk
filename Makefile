.PHONY: build-chefdk
build-chefdk: 
	docker build -t docker-chefdk .

.PHONY: run-chefdk
run-chefdk:
	docker run -it \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $HOME/Projects/chef/cookbooks:$HOME/cookbooks \ 
		-v $HOME/.gitconfig:$HOME/.gitconfig \
		-v $HOME/.vimrc:/home/aaronkalair/.vimrc \
		-v $HOME/.vim:$HOME/.vim \
		--name brentwg_chefdk \
		chefdk
		