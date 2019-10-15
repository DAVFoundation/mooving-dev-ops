local params = std.extVar('__ksonnet/params');
local globals = import 'globals.libsonnet';
local envParams = params {
  components+: {
    // Insert component parameter overrides here. Ex:
    // guestbook +: {
    //   name: "guestbook-dev",
    //   replicas: params.global.replicas,
    // },
    zookeeper+: {
      replicas: 1,
      cpu: '10m',
      memory: '50Mi',
      storage: '0.5Gi',
    },
    'kafka-deployment'+: {
      replicas: 3,
      cpu: '100m',
      memory: '100Mi',
      storage: '0.5Gi',
      'server.properties': importstr '../../vendor/kafka/server.properties.dev',
    },
    'storageclass-broker'+: {
      provisioner: 'k8s.io/minikube-hostpath',
      parameters: null,
    },
    'storageclass-zookeeper'+: {
      provisioner: 'k8s.io/minikube-hostpath',
      parameters: null,
    },
  },
};

{
  components: {
    [x]: envParams.components[x] + globals
    for x in std.objectFields(envParams.components)
  },
}
