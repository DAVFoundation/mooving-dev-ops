local k = import 'k.libsonnet';
local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['storageclass-zookeeper'];
{
  kind: 'StorageClass',
  apiVersion: 'storage.k8s.io/v1',
  metadata: {
    name: 'kafka-zookeeper',
  },
  provisioner: params.provisioner,
  reclaimPolicy: 'Retain',
  parameters: params.parameters,
}
