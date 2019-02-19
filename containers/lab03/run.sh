#!/bin/bash


. secret.sh $1

kubectl apply -f frontend-config.yml
kubectl apply -f backend.yml
kubectl apply -f frontend.yml
