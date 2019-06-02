VERSION?=beta
SCRIPT?=jenkins-master.sh
REPO_NAME?=kevinedwards
IMAGE_NAME?=jenkins-master
FOOTER_URL?=http://kevinedwards.ca

clean:

test:

tag:
	docker image tag 'kevinedwards/jenkins-master:$(VERSION)' 'kevinedwards/jenkins-master:latest'

build:
	docker build --no-cache -t 'kevinedwards/jenkins-master:$(VERSION)' .

run:
	docker container run --rm -idt \
	--name ${IMAGE_NAME} \
	--env JAVA_OPTS=-Dhudson.footerURL=$(FOOTER_URL) \
	-p 8080:8080 \
	-v /var/run/docker.sock:/var/run/docker.sock \
	$(REPO_NAME)/${IMAGE_NAME}:latest
