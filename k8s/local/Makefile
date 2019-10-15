FORCE:

install: FORCE
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo cp minikube /usr/local/bin/ && rm minikube
	sudo apt install libvirt-clients libvirt-daemon-system qemu-kvm
	sudo usermod -a -G libvirt $$(whoami)
	curl -Lo docker-machine-driver-kvm2 https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2
	chmod +x docker-machine-driver-kvm2
	sudo cp docker-machine-driver-kvm2 /usr/local/bin/
	rm docker-machine-driver-kvm2
	newgrp libvirt

start: FORCE
	-minikube delete
	minikube start --vm-driver kvm2

dashboard: FORCE
	minikube dashboard
