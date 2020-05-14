#!/bin/bash

kubectl delete -f deployment/mutatingwebhook-ca-bundle.yaml
kubectl delete -f deployment/service.yaml
kubectl delete -f deployment/deployment.yaml
kubectl delete -n lxcfs secret lxcfs-admission-webhook-certs

kubectl delete -f deployment/lxcfs-daemonset.yaml
kubectl delete ns lxcfs

