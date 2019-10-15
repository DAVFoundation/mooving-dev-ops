local env = std.extVar("__ksonnet/environments");
local params = std.extVar("__ksonnet/params").components["cassandra-statefulset"];
{
  "apiVersion": "apps/v1",
  "kind": "StatefulSet",
  "metadata": {
    "name": "cassandra",
    "namespace": params.namespace,
    "labels": {
      "app": "cassandra"
    }
  },
  "spec": {
    "serviceName": "cassandra",
    "replicas": params.replicas,
    "selector": {
      "matchLabels": {
        "app": "cassandra"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "app": "cassandra"
        }
      },
      "spec": {
        "terminationGracePeriodSeconds": params.terminationGracePeriodSeconds,
        "containers": [
          {
            "name": "cassandra",
            "image": "gcr.io/google-samples/cassandra:v13",
            "imagePullPolicy": "Always",
            "ports": [
              {
                "containerPort": 7000,
                "name": "intra-node"
              },
              {
                "containerPort": 7001,
                "name": "tls-intra-node"
              },
              {
                "containerPort": 7199,
                "name": "jmx"
              },
              {
                "containerPort": 9042,
                "name": "cql"
              }
            ],
            "resources": {
              "limits": {
                "cpu": params.limits.cpu,
                "memory": params.limits.memory
              },
              "requests": {
                "cpu": params.requests.cpu,
                "memory": params.requests.memory,
              }
            },
            "securityContext": {
              "capabilities": {
                "add": [
                  "IPC_LOCK"
                ]
              }
            },
            "lifecycle": {
              "preStop": {
                "exec": {
                  "command": [
                    "/bin/sh",
                    "-c",
                    "nodetool drain"
                  ]
                }
              }
            },
            "env": [
              {
                "name": "MAX_HEAP_SIZE",
                "value": "512M"
              },
              {
                "name": "HEAP_NEWSIZE",
                "value": "100M"
              },
              {
                "name": "CASSANDRA_SEEDS",
                "value": "cassandra-0.cassandra.cassandra.svc.cluster.local"
              },
              {
                "name": "CASSANDRA_CLUSTER_NAME",
                "value": "ride-hailing"
              },
              {
                "name": "CASSANDRA_DC",
                "value": "DC1"
              },
              {
                "name": "CASSANDRA_RACK",
                "value": "Rack1"
              },
              {
                "name": "POD_IP",
                "valueFrom": {
                  "fieldRef": {
                    "fieldPath": "status.podIP"
                  }
                }
              }
            ],
            "readinessProbe": {
              "exec": {
                "command": [
                  "/bin/bash",
                  "-c",
                  "/ready-probe.sh"
                ]
              },
              "initialDelaySeconds": 15,
              "timeoutSeconds": 5
            },
            "volumeMounts": [
              {
                "name": "cassandra-data",
                "mountPath": "/cassandra_data"
              }
            ]
          }
        ]
      }
    },
    "volumeClaimTemplates": [
      {
        "metadata": {
          "name": "cassandra-data"
        },
        "spec": {
          "accessModes": [
            "ReadWriteOnce"
          ],
          "storageClassName": "cassandra-storage",
          "resources": {
            "requests": {
              "storage": params.requests.storage
            }
          }
        }
      }
    ]
  }
}
