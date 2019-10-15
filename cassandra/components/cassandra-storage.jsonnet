local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['cassandra-storage'];
{
  kind: 'StorageClass',
  apiVersion: 'storage.k8s.io/v1',
  metadata: {
    name: 'cassandra-storage',
    namespace: params.namespace,
  },
  reclaimPolicy: 'Retain',
  provisioner: params.storageProvisioner,
  parameters: params.storageParameters,
}
