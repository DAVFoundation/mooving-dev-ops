MINIKUBE_IP=$(shell minikube ip)

FORCE:

install:
	echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
	sudo apt-get update
	sudo apt-get install sbt

build: TIMESTAMP=$(shell date +%y%m%d-%H%M -u)
build:
	@echo Building with timestamp $(TIMESTAMP)
	docker build . -f Dockerfile -t flink:$(TIMESTAMP)
	docker push flink:$(TIMESTAMP)

deploy-flink-controller: FORCE
	-kubectl create namespace metacontroller
	kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/metacontroller/master/manifests/metacontroller-rbac.yaml
	kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/metacontroller/master/manifests/metacontroller.yaml
	kubectl apply -f https://raw.githubusercontent.com/srfrnk/k8s-flink-operator/master/dist/flink-controller.yaml

remove-flink-controller: FORCE
	kubectl delete -f https://raw.githubusercontent.com/srfrnk/k8s-flink-operator/master/dist/flink-controller.yaml
	kubectl delete -f https://raw.githubusercontent.com/GoogleCloudPlatform/metacontroller/master/manifests/metacontroller.yaml
	kubectl delete -f https://raw.githubusercontent.com/GoogleCloudPlatform/metacontroller/master/manifests/metacontroller-rbac.yaml
	kubectl delete namespace metacontroller

deploy-local: FORCE
	ks env set local --server=https://$(MINIKUBE_IP):8443 && ks apply local --ext-str IMAGE_VERSION=$(VERSION)

remove-local: FORCE
	ks env set local --server=https://$(MINIKUBE_IP):8443 && ks delete local --ext-str IMAGE_VERSION=latest
