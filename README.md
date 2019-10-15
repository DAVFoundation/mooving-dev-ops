# mooving-dev-ops

## K8S

Support for local/dev env and gcp/prod env.

### Ksonnet

**For Ubuntu (or other Debian based distros)**
Install:

```bash
cd ksonnet
make install
```

**For other systems**

Install [ksonnet](https://ksonnet.io/)

### Local/DEV

#### Install

**For Ubuntu (or other Debian based distros)**

Install minikube + dependencies using:

```bash
cd k8s/local
make install
```

Start minikube using:

```bash
make local-start
```

**For other systems**

Install [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) using instructions.

#### Dashboard

Open minikube dashboard:

```bash
make local-start
```

Open dashboard using:

```bash
make local-dashboard
```

### GCP/PROD

#### Install

**For Ubuntu (or other Debian based distros)**

```bash
cd k8s/gcp
make install
```

**For other systems**

Install [Google Cloud SDK](https://cloud.google.com/sdk/) and
[kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl).

## Install Parallel (only when contributing code)

Ubuntu/Debian

```bash
sudo apt install parallel
```

## Flink

1. Install [Java 8](https://openjdk.java.net/install/)
1. Install [SBT](https://www.scala-sbt.org/) (Ubuntu users can run `make install` in the `flink` folder)

## Initial Secrets Setup

- Open `.../mooving/mooving-dev-ops/firebase/config.json`
- Set `version.updateUser.email` to the id of an admin firebase service account (e.g. `firebase-adminsdk-...@...iam.gserviceaccount.com`)

- Open `.../mooving/mooving-flow/k8s/environments/local/params.libsonnet`
- Set `GCP_PROJECT` to your GCP project id
- Set `GCP_BUCKET_PATH` to a a GCS bucket path
- Set `end-ride/gcsBucket` to a a GCS bucket path for invoices
- Set `end-ride/GCP_CREDENTIALS_FILE_NAME` under to filename of a JSON service account file.
- Set `token-txn/ethNodeUrl` to your eth wallet address.

## How to run locally

### Setup

- Install [`minikube`](https://kubernetes.io/docs/tasks/tools/install-minikube/)
- Install the rest of the toolchain
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

### Start

Run:

```bash
minikube start
minikube addons enable ingress
```

#### dev-ops

cd to `dev-ops` folder and run:

```bash
make deploy
```

#### Flows

cd to `flows` folder and run:

```bash
make local-deploy
```

#### API

##### Run in K8S

cd to `api` folder and run:

```bash
make local-deploy
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

```bash
export TWILIO_API_KEY='<<YOUR_TWILIO_API_KEY>>'
export SDK_DEBUG_LOG=true
```

cd to `dev-ops` folder and run:

```bash
make proxy-all
```

Note: **DO NOT CLOSE THE PROXY TERMINAL**

cd to `api` folder and run either:

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
