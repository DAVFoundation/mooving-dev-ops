{
  replicas: 2,
  terminationGracePeriodSeconds: 10,
  limits: {
    cpu: '1000m',
    memory: '1Gi',
  },
  requests: {
    cpu: '10m',
    memory: '50Mi',
    storage: '0.5Gi',
  },
  storageProvisioner: 'k8s.io/minikube-hostpath',
  storageParameters: null,
}
