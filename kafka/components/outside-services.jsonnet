local k = import 'k.libsonnet';
local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['outside-services'];
k.core.v1.list.new([
  {
    kind: 'Service',
    apiVersion: 'v1',
    metadata: {
      name: 'outside-0',
      namespace: params.namespace,
    },
    spec: {
      selector: {
        app: 'kafka',
        'kafka-broker-id': '0',
      },
      ports: [
        {
          protocol: 'TCP',
          targetPort: 9094,
          port: 32400,
          nodePort: 32400,
        },
      ],
      type: 'NodePort',
    },
  },
  {
    kind: 'Service',
    apiVersion: 'v1',
    metadata: {
      name: 'outside-1',
      namespace: params.namespace,
    },
    spec: {
      selector: {
        app: 'kafka',
        'kafka-broker-id': '1',
      },
      ports: [
        {
          protocol: 'TCP',
          targetPort: 9094,
          port: 32401,
          nodePort: 32401,
        },
      ],
      type: 'NodePort',
    },
  },
  {
    kind: 'Service',
    apiVersion: 'v1',
    metadata: {
      name: 'outside-2',
      namespace: params.namespace,
    },
    spec: {
      selector: {
        app: 'kafka',
        'kafka-broker-id': '2',
      },
      ports: [
        {
          protocol: 'TCP',
          targetPort: 9094,
          port: 32402,
          nodePort: 32402,
        },
      ],
      type: 'NodePort',
    },
  },
])
