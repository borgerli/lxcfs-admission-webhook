#!/bin/bash
kubectl create namespace lxcfs
kubectl create -f deployment/lxcfs-daemonset.yaml

echo -n "waiting lxcfs daemon pod to start"
until kubectl get pod -n lxcfs -l app=lxcfs 2>/dev/null| grep -i "running" &>/dev/null;do echo -n "." && sleep 1;done
echo -n -e "started!\n"

./deployment/webhook-create-signed-cert.sh --namespace lxcfs
kubectl get secret -n lxcfs lxcfs-admission-webhook-certs

kubectl create -f deployment/deployment.yaml
kubectl create -f deployment/service.yaml
cat ./deployment/mutatingwebhook.yaml | ./deployment/webhook-patch-ca-bundle.sh > ./deployment/mutatingwebhook-ca-bundle.yaml
kubectl create -f deployment/mutatingwebhook-ca-bundle.yaml

