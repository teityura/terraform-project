.PHONY: default setup module config link

default: deploy
setup: module config link

module:
	@if [ ! -d template ]; then \
		echo "=== Adding template ==="; \
		git submodule add https://github.com/teityura/terraform-template.git template; \
	else \
		echo "=== Updating template ==="; \
		git submodule update --init --recursive --remote template; \
	fi

config: module
	@echo "=== Creating tfvars ==="
	cp --update=none ./template/terraform/terraform.tfvars.sample ./terraform.tfvars
	@echo "=== Current configuration ==="
	cat ./terraform.tfvars

	@echo "=== Creating site.yml ==="
	cp --update=none ./template/ansible/site.yml.sample ./site.yml
	@echo "=== Current configuration ==="
	cat ./site.yml

link: config
	ln -sf ./terraform.tfvars ./template/terraform/terraform.tfvars
	ln -sf ./site.yml ./template/ansible/site.yml

%:
	$(MAKE) -C template $@

