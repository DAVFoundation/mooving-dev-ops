local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['flink-namespace'];
{
  apiVersion: 'v1',
  kind: 'Namespace',
  metadata: {
    labels: {
      name: 'flink',
    },
    name: 'flink',
  },
}
