# mooving-dev-ops
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2FDAVFoundation%2Fmooving-dev-ops.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2FDAVFoundation%2Fmooving-dev-ops?ref=badge_shield)


## Initial Secrets Setup

- Open `.../mooving/mooving-dev-ops/firebase/config.json`
- Set `version.updateUser.email` to the id of an admin firebase service account (e.g. `firebase-adminsdk-...@...iam.gserviceaccount.com`)

- Open `.../mooving/mooving-flow/k8s/environments/local/params.libsonnet`
- Set `GCP_PROJECT` to your GCP project id
- Set `GCP_BUCKET_PATH` to a a GCS bucket path
- Set `end-ride/gcsBucket` to a a GCS bucket path for invoices
- Set `end-ride/GCP_CREDENTIALS_FILE_NAME` under to filename of a JSON service account file.
- Set `token-txn/ethNodeUrl` to your eth wallet address.

- Open `.../mooving/mooving-api/k8s/environments/local/params.libsonnet`
- Set `GCP_PROJECT` under `owner-deployment`, `rider-deployment` and `dav-rate-update-job` to your GCP project id.
- Set `MAILGUN_DOMAIN` under `owner-deployment` and `rider-deployment` to your MAILGUN domain.
- Under `rider-deployment` set `BLUE_SNAP_USER_NAME`,`BLUE_SNAP_USER_NAME_TEST_USER` to BlueSnap credentials
- Under `rider-deployment` set `IOS_APP_ID` to your iOS app id.
- Under `rider-deployment` set `GCP_CREDENTIALS_FILE_NAME` to the name of the service account file.
- Under `rider-deployment` set `INVOICES_BUCKET_NAME` to a GCS Bucket name.
- Set `hostName` under `rider-ingress`,`owner-ingress` and `get-dav-city-ingress` to your hostnames.

- Open `.../mooving/mooving-api/k8s/vendor/nginx/nginx.conf`
- Replace `*.dav.city` with your host.

- Open `.../mooving/mooving-api/k8s/Makefile`
- Set `<GCP_PROJECT>` to your GCP project id.

- Open `.../mooving/mooving-api/src/common/controllers/AccountController.test.ts`
- Set `TEST_USER_PHONE` to some phone number.
- Set `TEST_USER_COUNTRY_CODE` to some phone country code.

- Open `.../mooving/mooving-api/src/common/controllers/AccountController.ts`
- Set `TEST_USER_PHONE_NUMBER` to some phone number.
- Set `TEST_USER_COUNTRY_CODE` to some phone country code.

- Open `/data/shahar/code/mooving/mooving-api/src/owner/TestUserApi.test.ts`
- Set `TEST_USER_PHONE_NUMBER` to some phone number.
- Set `REGULAR_USER_PHONE_NUMBER` to some phone number.

- Open `.../mooving/mooving-api/src/rider/controllers/AccountController.ts`
- Set `GCS_BUCKET` to your GCS bucket.

- Open `.../mooving/mooving-api/src/rider/controllers/DeeplinksController.ts`
- Set `<IOS_APP_ID>` to your ios app id.
- Set `<HOSTNAME>` to your hostname
- Set `<ITUNES_URL>` to your itunes url

- Open `.../mooving/mooving-api/local-env.sh`
- Set `TWILIO_API_KEY`, `BLUE_SNAP_USER_NAME`, `BLUE_SNAP_PASSWORD`, `BLUE_SNAP_USER_NAME_TEST_USER` and `BLUE_SNAP_PASSWORD_TEST_USER`

## How to run locally

### Setup

[Docker Install](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-engine---community)

```bash
cd ksonnet
make install
```

```bash
sudo apt install parallel
```

Then:

```bash
sudo apt install python-pip
pip install cqlsh
```

- Install [KVM](https://linuxconfig.org/install-and-set-up-kvm-on-ubuntu-18-04-bionic-beaver-linux)
- Install [`minikube`](https://kubernetes.io/docs/tasks/tools/install-minikube/)
- Save this into `~/.minikube/config/config.json`:

```json
{
  "WantReportError": true,
  "cpus": 6,
  "dashboard": true,
  "disk-size": "30GB",
  "ingress": true,
  "memory": 16000,
  "profile": "minikube",
  "vm-driver": "kvm2"
}
```

- Edit `~/.cassandra/cqlshrc` with the following content:

```
[cql]
version=3.4.4
```

Setup [NodeJS](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions-enterprise-linux-fedora-and-snap-packages)

### Start

Run:

```bash
minikube start
```

#### dev-ops

Edit `./Makefile` and replace secret values with real values (e.g. <<YOUR_CMC_API_KEY>>)

cd to `dev-ops` folder and run:

```bash
make secrets-setup
```

And then run:

```bash
make deploy
```

#### Flows

Edit `k8s/environments/local/params.libsonnet` and replace secret values with real values (e.g. <<YOUR_CMC_API_KEY>>)
Edit `Makefile` and replace <<GCP_PROJECT_ID>> with your project id.

cd to `flows` folder and run:

```bash
make deploy
```

#### API

##### Run in K8S

Edit `k8s/environments/local/params.libsonnet` and replace secret values with real values (e.g. <<YOUR_CMC_API_KEY>>)
Edit `k8s/Makefile` and replace secret values with real values (e.g. <<YOUR_CMC_API_KEY>>)

cd to `api` folder and run:

```bash
make deploy
```

Use either:

```bash
kubectl port-forward -n mooving svc/api-rider 3005:80
```

Or:

```bash
kubectl port-forward -n mooving svc/api-owner 3005:80
```

##### Run locally

Edit `local-env.sh` and replace secret values with real values (e.g. <<YOUR_CMC_API_KEY>>)

cd to `dev-ops` folder and run:

```bash
make proxy-all
```

Note: **DO NOT CLOSE THE PROXY TERMINAL**

cd to `api` folder and run:

```bash
npm i
```

Then run either:

```bash
make start-rider
```

Or:

```bash
make start-owner
```

#### Run APP

##### Android

cd to 'app' folder and run

```bash
make start-android-emu
```

Then run either:

```bash
make android-rider-local
```

Or:

```bash
make android-owner-local
```

##### Ios

cd to 'app' folder and run

Then run either:

```bash
make ios-rider
```

Or:

```bash
make ios-owner
```


## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2FDAVFoundation%2Fmooving-dev-ops.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2FDAVFoundation%2Fmooving-dev-ops?ref=badge_large)