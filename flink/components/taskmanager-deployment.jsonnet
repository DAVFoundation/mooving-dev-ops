local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['taskmanager-deployment'];
local version = std.extVar('IMAGE_VERSION');
{
  apiVersion: 'extensions/v1beta1',
  kind: 'Deployment',
  metadata: {
    name: 'flink-taskmanager',
    namespace: 'flink',
  },
  spec: {
    replicas: params.replicas,
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
            volumeMounts: [
              {
                name: 'gcp-credentials-volume',
                mountPath: '/gcp-credentials',
                readOnly: true,
              },
            ],
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
        volumes: [
          {
            name: 'gcp-credentials-volume',
            secret: {
              secretName: 'gcp-credentials',
            },
          },
        ],
      },
    },
  },
}
