FORCE:

install:
	- mkdir ~/tmp
	curl -L https://github.com/ksonnet/ksonnet/releases/download/v0.13.0/ks_0.13.0_linux_amd64.tar.gz \
		| tar xz -C ~/tmp
	sudo cp ~/tmp/ks_0.13.0_linux_amd64/ks /usr/local/bin
	echo "export KUBECONFIG=~/.kube/config" >> ~/.bashrc

	git clone https://github.com/srfrnk/jsonnet-releases.git
	cd jsonnet-releases && make compile
	sudo mv jsonnet-releases/jsonnet /usr/local/bin
	rm -rf jsonnet-releases
