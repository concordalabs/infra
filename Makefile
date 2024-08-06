bootstrap:
	helm repo add argo https://argoproj.github.io/argo-helm
	helm upgrade --install argo argo/argo-cd --namespace argocd --values argocd/values.yaml
	argocd cluster add do-fra1-concorda-dev-fra1

install/apps:
	argocd app create apps --upsert \
			--dest-namespace argocd \
			--dest-server https://kubernetes.default.svc \
			--repo https://github.com/concordalabs/infra.git \
			--path apps \
			--values values-dev-fra1.yaml
	argocd app sync apps --prune
