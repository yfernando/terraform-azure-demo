.PHONY: all plan apply destroy

AZURE_CREDS = ~/.azure_credentials/azure.credentials.tfvars

all:
		@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

plan: ## Generate and show an execution plan.
	terraform get
  terraform plan -var-file=$(AZURE_CREDS)

apply: ## Builds or changes infrastructure.
	terraform apply -var-file=$(AZURE_CREDS)

destroy: ## Destroy Terraform-managed infrastructure. BE CAREFUL!!!
	terraform destroy -var-file=$(AZURE_CREDS)
