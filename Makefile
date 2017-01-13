.PHONY: all plan apply destroy

AZURE_CREDS = ~/.azure_credentials/azure.credentials.tfvars

all:
	@echo Options are: plan,apply,destroy.

plan:
	terraform get
  terraform plan -var-file=$(AZURE_CREDS)

apply:
	terraform apply -var-file=$(AZURE_CREDS)

destroy:
	terraform destroy -var-file=$(AZURE_CREDS)
