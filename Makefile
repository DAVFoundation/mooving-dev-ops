SHELL := /bin/bash

FORCE:

proxy-all:
	parallel ::: \
		"kubectl proxy" \
		"kubectl port-forward -n kafka statefulset/zoo 2181:2181" \
		"kubectl port-forward -n cassandra statefulset/cassandra 9042:9042" \
		"kubectl port-forward -n flink svc/flink-jobmanager 8082:8081" \
		"kubectl port-forward svc/node-red 1880:1880" \
		"kubectl -n kafka port-forward pod/kafka-0 9092:9094 32400:9092" \
		"kubectl -n kafka port-forward pod/kafka-1 32401:9092" \
		"kubectl -n kafka port-forward pod/kafka-2 32402:9092"

deploy: TIMESTAMP=$(shell date +%y%m%d-%H%M -u)
deploy: use-local
	eval "$$(minikube docker-env)" &&\
		docker build flink -f flink/Dockerfile -t flink:$(TIMESTAMP)

	pushd cassandra && ks show local -o json --ext-str IMAGE_VERSION=$(TIMESTAMP) > dist/cassandra.json && popd
	pushd flink && ks show local -o json --ext-str IMAGE_VERSION=$(TIMESTAMP) > dist/flink.json && popd
	pushd kafka && ks show local -o json --ext-str IMAGE_VERSION=$(TIMESTAMP) > dist/kafka.json && popd

	-kubectl create namespace metacontroller
	kubectl apply -f https://raw.githubusercontent.com/srfrnk/metacontroller/master/manifests/metacontroller-rbac.yaml
	kubectl apply -f https://raw.githubusercontent.com/srfrnk/metacontroller/master/manifests/metacontroller.yaml
	kubectl apply -f https://raw.githubusercontent.com/srfrnk/k8s-flink-operator/master/dist/flink-controller.yaml

	kubectl apply -f kafka/dist/kafka.json
	kubectl apply -f cassandra/dist/cassandra.json
	kubectl apply -f flink/dist/flink.json

	kubectl wait --for=condition=ready --timeout=600s -n cassandra pod/cassandra-0
	sleep 30
	kubectl port-forward -n cassandra statefulset/cassandra 9042:9042 & echo $$! > /tmp/id
	sleep 5
	pushd cassandra/schema/vehicle_rider && cqlsh -f create-all.cql && popd
	pushd cassandra/schema/vehicle_rider && cqlsh -f generate_test_user.cql && popd
	sleep 2
	cat /tmp/id | xargs kill
