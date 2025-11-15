.PHONY: default setup dir mod conf link

default: deploy
setup: mod dir conf link

dir:
	mkdir -p inventories/group_vars/all
	mkdir -p inventories/host_vars
	mkdir -p roles/test/tasks/

mod:
	@if [ ! -d template ]; then \
		git submodule add https://github.com/teityura/terraform-template.git template; \
	else \
		git submodule update --init --recursive --remote template; \
	fi

conf: mod
	@echo "=== Creating tfvars ==="
	cp --update=none ./template/terraform/terraform.tfvars.sample ./terraform.tfvars
	cat ./terraform.tfvars

	@echo "=== Creating site.yml ==="
	cp --update=none ./template/ansible/site.yml.sample ./site.yml
	cat ./site.yml

link: conf
	@echo "=== Creating dir ==="
	ln -sf ../../terraform.tfvars ./template/terraform/terraform.tfvars
	ln -sf ../../site.yml ./template/ansible/site.yml

%:
	$(MAKE) -C template $@
