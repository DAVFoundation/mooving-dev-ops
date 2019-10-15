local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['jobmanager-deployment'];
local version = std.extVar('IMAGE_VERSION');
{
  apiVersion: 'apps/v1',
  kind: 'StatefulSet',
  metadata: {
    name: 'flink-jobmanager',
    namespace: 'flink',
  },
  spec: {
    serviceName: 'flink-jobmanager',
    replicas: 1,
    selector: {
      matchLabels: {
        app: 'flink',
        component: 'jobmanager',
      },
    },
    template: {
      metadata: {
        labels: {
          app: 'flink',
          component: 'jobmanager',
        },
      },
      spec: {
        containers: [
          {
            name: 'jobmanager',
            image: 'flink:' + version,
            args: [
              'jobmanager',
            ],
            ports: [
              {
                containerPort: 6123,
                name: 'rpc',
              },
              {
                containerPort: 6124,
                name: 'blob',
              },
              {
                containerPort: 6125,
                name: 'query',
              },
              {
                containerPort: 8081,
                name: 'ui',
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
