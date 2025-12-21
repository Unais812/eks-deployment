SHELL := /bin/bash

HELM := helm
KUBECTL := kubectl

EXTERNAL_DNS_NS := external-dns
INGRESS_NS := ingress-nginx
CERT_MANAGER_NS := cert-manager

.PHONY: all deploy helm external-dns ingress-nginx cert-manager k8s manifests verify

all: deploy

deploy: helm manifests

helm: external-dns ingress-nginx cert-manager

external-dns:
	$(HELM) upgrade --install external-dns external-dns \
		--namespace $(EXTERNAL_DNS_NS) \
		--create-namespace \
		--repo https://kubernetes-sigs.github.io/external-dns \
		--version 1.15.0 \
		-f ./values.yaml

ingress-nginx:
	$(HELM) upgrade --install nginx ingress-nginx/ingress-nginx \
		--namespace $(INGRESS_NS) \
		--create-namespace

cert-manager:
	$(HELM) upgrade --install cert-manager oci://quay.io/jetstack/charts/cert-manager \
		--namespace $(CERT_MANAGER_NS) \
		--create-namespace \
		--set crds.enabled=true

manifests:
	$(KUBECTL) apply -f deployment.yaml
	$(KUBECTL) apply -f ingress.yaml
	$(KUBECTL) apply -f clusterissuer.yaml

verify:
	$(KUBECTL) get pods -A
	$(KUBECTL) get ingress
	$(KUBECTL) get certificate -A || true
