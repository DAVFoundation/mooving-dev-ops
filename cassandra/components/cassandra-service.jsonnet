local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['cassandra-service'];
{
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    labels: {
      app: 'cassandra',
    },
    name: 'cassandra',
    namespace: params.namespace,
  },
  spec: {
    ports: [
      {
        protocol: 'TCP',
        port: 9042,
        targetPort: 9042,
      },
    ],
    selector: {
      app: 'cassandra',
    },
    clusterIP: 'None',
  },
}
