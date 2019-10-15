MINIKUBE_IP=$(shell minikube ip)

FORCE:

create-schema: FORCE
	cd ./schema/vehicle_rider && cqlsh -f ./create-all.cql

drop-schema: FORCE
	cd ./schema/vehicle_rider && cqlsh -f ./drop-all.cql

deploy-local: FORCE
	ks env set local --server=https://$(MINIKUBE_IP):8443 && ks apply local --ext-str IMAGE_VERSION=$(VERSION)

remove-local: FORCE
	ks env set local --server=https://$(MINIKUBE_IP):8443 && ks delete local --ext-str IMAGE_VERSION=latest

start-proxy: FORCE
	parallel ::: \
		"kubectl port-forward --namespace=cassandra statefulset/cassandra 9042:9042" \
		"kubectl port-forward --namespace=cassandra deployment/cassandra-web 8010:3000"
