FORCE:

# Installation instructions
# MacOS:
#   * Install GCP - https://cloud.google.com/sdk/docs/#mac
#   * Install KubeCTL - https://kubernetes.io/docs/tasks/tools/install-kubectl/
# Ubuntu/Debian:
install: FORCE
	export CLOUD_SDK_REPO="cloud-sdk-$$(lsb_release -c -s)" && echo "deb http://packages.cloud.google.com/apt $$CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install google-cloud-sdk kubectl

	echo "source <(kubectl completion bash)" >> ~/.bashrc

	gcloud init

connect-cluster: FORCE
	gcloud container clusters get-credentials staging --zone us-east1-c --project dav-ride-hailing
	# kubectl create clusterrolebinding shahar-cluster-admin-binding --clusterrole=cluster-admin --user=shahar@dav.network
	kubectl apply -f dashboard-role-binding.yml
