#!/bin/bash

KUBE_DIR="kubernetes"
RABBITMQ_USER="mueiya"
RABBITMQ_PASS="secretpassword"
RABBITMQ_COOKIE="secretcookie"


# Using helm for installing the rabbit mq
echo "Installing rabbit mq using helm..."
helm install my-rabbitmq --set auth.username=$RABBITMQ_USER,auth.password=$RABBITMQ_PASS,auth.erlangCookie=$RABBITMQ_COOKIE \ bitnami/rabbitmq
echo "rabbit mq username is $RABBITMQ_USER"
echo "rabbit mq password is $RABBITMQ_PASS"
echo "rabbit mq password is $RABBITMQ_COOKIE"


# Apply the namespace
echo "Applying the namespace..."
kubectl apply -f "$KUBE_DIR/namespace.yml"

# Apply the order-service
echo "Applying the order-service..."
kubectl apply -f "$KUBE_DIR/order/order-service.yml"
kubectl apply -f "$KUBE_DIR/order/order-deployment.yml"

# Apply the shipping-service
echo "Applying the shipping-service..."
kubectl apply -f "$KUBE_DIR/shipping/shipping-service.yml"
kubectl apply -f "$KUBE_DIR/shipping/shipping-deployment.yml"
