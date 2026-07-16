.PHONY: generate apply clean

CTX ?= default/api-cluster-5przf-5przf-sandbox2144-opentlc-com:6443/kube:admin

generate:
	python3 generate-catalog.py -o generated-catalog.yaml

apply: generate
	oc apply -f generated-catalog.yaml --context=$(CTX)
	@echo ""
	@echo "Catalog updated. Restart dashboard to pick up changes:"
	@echo "  oc rollout restart deployment/rhods-dashboard -n redhat-ods-applications --context=$(CTX)"

clean:
	rm -f generated-catalog.yaml
