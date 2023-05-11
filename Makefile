NS = uktrade
NAME = xmlsec1
INSTANCE = default
VERSION ?= 1.2.37

.PHONY: build shell rm build release rmi

xmlsec1-${VERSION}.sig:

	wget https://www.aleksey.com/xmlsec/download/xmlsec1-${VERSION}.sig

build: xmlsec1-${VERSION}.sig
	docker build --platform linux/amd64 -t $(NS)/$(NAME):$(VERSION) --build-arg VERSION=${VERSION} .

shell:
	docker run --platform linux/amd64 --rm --name $(NAME)-$(INSTANCE) -i -t $(NS)/$(NAME):$(VERSION) /bin/bash

release:
	docker run --platform linux/amd64 --rm --name $(NAME)-$(INSTANCE) $(NS)/$(NAME):$(VERSION) > ./xmlsec.tar.gz

rm:
	docker rm $(NAME)-$(INSTANCE)

rmi:
	docker rmi $(NS)/$(NAME)

clean:
	rm ./xmlsec1.tar.gz

default: build
