local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['taskmanager-deployment'];
local version = std.extVar('IMAGE_VERSION');
{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    name: 'flink-taskmanager',
    namespace: 'flink',
  },
  spec: {
    replicas: params.replicas,
    selector: {
      matchLabels: {
        app: 'flink',
        component: 'taskmanager',
      },
    },
    template: {
      metadata: {
        labels: {
          app: 'flink',
          component: 'taskmanager',
        },
      },
      spec: {
        containers: [
          {
            name: 'taskmanager',
            image: 'flink:' + version,
            args: [
              'taskmanager',
            ],
            ports: [
              {
                containerPort: 6121,
                name: 'data',
              },
              {
                containerPort: 6122,
                name: 'rpc',
              },
              {
                containerPort: 6125,
                name: 'query',
              },
            ],
            resources: {
              limits: {
                cpu: params.limits.cpu,
                memory: params.limits.memory,
              },
              requests: {
                cpu: params.requests.cpu,
                memory: params.requests.memory,
              },
            },
            env: [
              {
                name: 'JOB_MANAGER_RPC_ADDRESS',
                value: 'flink-jobmanager',
              },
              {
                name: 'GOOGLE_APPLICATION_CREDENTIALS',
                value: '/gcp-credentials/' + params.GCP_CREDENTIALS_FILE_NAME,
              },
            ],
          },
        ],
      },
    },
  },
}
