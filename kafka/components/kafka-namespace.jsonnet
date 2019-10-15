local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['kafka-namespace'];
{
  apiVersion: 'v1',
  kind: 'Namespace',
  metadata: {
    labels: {
      name: params.namespace,
    },
    name: params.namespace,
  },
}
