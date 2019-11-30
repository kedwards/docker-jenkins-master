.ONESHELL:

VERSION?=beta
REPO?=kevinedwards
IMAGE?=jenkins-master
SCRIPT?=$(IMAGE).sh
FOOTER_URL?=http://$(REPO).ca

clean:
	@docker image rm '$(REPO)/$(IMAGE):$(VERSION)'

clean-force:
	@docker image rm '$(REPO)/$(IMAGE):$(VERSION)' --force

test:

tag:
	docker image tag '$(REPO)/$(IMAGE):$(VERSION)' '$(REPO)/$(IMAGE):latest'

build:
	docker build --no-cache -t '$(REPO)/$(IMAGE):$(VERSION)' .

machine:
	docker-machine -D create \
	-d generic \
	--generic-ip-address 192.168.100.150 \
	--generic-ssh-port 22 \
	--generic-ssh-key "C:/Users/kedwa/dev/jenkins/.vagrant/machines/jenkins-master/virtualbox/private_key" \
	--generic-ssh-user vagrant \
	jenkins

run:
	@docker container run --rm -idt \
	--name ${IMAGE} \
	--env JAVA_OPTS=-Dhudson.footerURL=$(FOOTER_URL) \
	-p 8080:8080 \
	-v $$(pwd)/jenkins_home:/var/jenkins_home \
	-v /var/run/docker.sock:/var/run/docker.sock \
	$(REPO)/${IMAGE}:$(VERSION)
