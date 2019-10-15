local params = std.extVar('__ksonnet/params');
local globals = import 'globals.libsonnet';
local envParams = params {
  components+: {
    // Insert component parameter overrides here. Ex:
    // guestbook +: {
    //   name: "guestbook-dev",
    //   replicas: params.global.replicas,
    // },
    'jobmanager-deployment'+: {
      limits: {
        cpu: '1000m',
        memory: '2Gi',
      },
      requests: {
        cpu: '500m',
        memory: '1Gi',
      },
      GCP_CREDENTIALS_FILE_NAME: 'mooving-development-cassandra-backup-service-account.json',
    },
    'taskmanager-deployment'+: {
      replicas: 1,
      limits: {
        cpu: '1000m',
        memory: '4Gi',
      },
      requests: {
        cpu: '500m',
        memory: '2Gi',
      },
      GCP_CREDENTIALS_FILE_NAME: 'mooving-development-cassandra-backup-service-account.json',
    },
  },
};

{
  components: {
    [x]: envParams.components[x] + globals
    for x in std.objectFields(envParams.components)
  },
}
