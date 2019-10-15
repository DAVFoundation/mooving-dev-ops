MINIKUBE_IP=$(shell minikube ip)

FORCE:

deploy-local: FORCE
	ks env set local --server=https://$(MINIKUBE_IP):8443 && ks apply local --ext-str IMAGE_VERSION=$(VERSION)

remove-local: FORCE
	ks env set local --server=https://$(MINIKUBE_IP):8443 && ks delete local --ext-str IMAGE_VERSION=latest
