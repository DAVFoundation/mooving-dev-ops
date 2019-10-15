local k = import 'k.libsonnet';
local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['kafka-deployment'];
k.core.v1.list.new([
  {
    kind: 'ConfigMap',
    metadata: {
      name: 'broker-config',
      namespace: params.namespace,
    },
    apiVersion: 'v1',
    data: {
      'init.sh': importstr '../vendor/kafka/init.sh',
      'server.properties': params['server.properties'],
      'log4j.properties': importstr '../vendor/kafka/log4j.properties',
    },
  },
  {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: 'broker',
      namespace: params.namespace,
    },
    spec: {
      ports: [
        {
          port: 9092,
        },
      ],
      clusterIP: 'None',
      selector: {
        app: 'kafka',
      },
    },
  },
  {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: 'bootstrap',
      namespace: params.namespace,
    },
    spec: {
      ports: [
        {
          port: 9092,
        },
      ],
      selector: {
        app: 'kafka',
      },
    },
  },
  {
    apiVersion: 'apps/v1',
    kind: 'StatefulSet',
    metadata: {
      name: 'kafka',
      namespace: params.namespace,
    },
    spec: {
      selector: {
        matchLabels: {
          app: 'kafka',
        },
      },
      serviceName: 'broker',
      replicas: params.replicas,
      updateStrategy: {
        type: 'OnDelete',
      },
      template: {
        metadata: {
          labels: {
            app: 'kafka',
          },
          annotations: null,
        },
        spec: {
          terminationGracePeriodSeconds: 30,
          initContainers: [
            {
              name: 'init-config',
              image: 'solsson/kafka-initutils@sha256:18bf01c2c756b550103a99b3c14f741acccea106072cd37155c6d24be4edd6e2',
              env: [
                {
                  name: 'NODE_NAME',
                  valueFrom: {
                    fieldRef: {
                      fieldPath: 'spec.nodeName',
                    },
                  },
                },
                {
                  name: 'POD_NAME',
                  valueFrom: {
                    fieldRef: {
                      fieldPath: 'metadata.name',
                    },
                  },
                },
                {
                  name: 'POD_NAMESPACE',
                  valueFrom: {
                    fieldRef: {
                      fieldPath: 'metadata.namespace',
                    },
                  },
                },
              ],
              command: [
                '/bin/bash',
                '/etc/kafka-configmap/init.sh',
              ],
              volumeMounts: [
                {
                  name: 'configmap',
                  mountPath: '/etc/kafka-configmap',
                },
                {
                  name: 'config',
                  mountPath: '/etc/kafka',
                },
              ],
            },
          ],
          containers: [
            {
              name: 'broker',
              image: 'solsson/kafka:1.0.2@sha256:7fdb326994bcde133c777d888d06863b7c1a0e80f043582816715d76643ab789',
              env: [
                {
                  name: 'KAFKA_LOG4J_OPTS',
                  value: '-Dlog4j.configuration=file:/etc/kafka/log4j.properties',
                },
                {
                  name: 'JMX_PORT',
                  value: '5555',
                },
              ],
              ports: [
                {
                  name: 'inside',
                  containerPort: 9092,
                },
                {
                  name: 'outside',
                  containerPort: 9094,
                },
                {
                  name: 'jmx',
                  containerPort: 5555,
                },
              ],
              command: [
                './bin/kafka-server-start.sh',
                '/etc/kafka/server.properties',
              ],
              resources: {
                requests: {
                  cpu: params.cpu,
                  memory: params.memory,
                },
              },
              readinessProbe: {
                tcpSocket: {
                  port: 9092,
                },
                timeoutSeconds: 1,
              },
              volumeMounts: [
                {
                  name: 'config',
                  mountPath: '/etc/kafka',
                },
                {
                  name: 'data',
                  mountPath: '/var/lib/kafka/data',
                },
              ],
            },
          ],
          volumes: [
            {
              name: 'configmap',
              configMap: {
                name: 'broker-config',
              },
            },
            {
              name: 'config',
              emptyDir: {},
            },
          ],
        },
      },
      volumeClaimTemplates: [
        {
          metadata: {
            name: 'data',
          },
          spec: {
            accessModes: [
              'ReadWriteOnce',
            ],
            storageClassName: 'kafka-broker',
            resources: {
              requests: {
                storage: params.storage,
              },
            },
          },
        },
      ],
    },
  },
])
