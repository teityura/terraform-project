# terraform-project

Example OpenStack infrastructure project using [terraform-template](https://github.com/teityura/terraform-template).

## Usage

```bash
# Clone
project_name="myproject"
mkdir -p ~/terra/
cd ~/terra/
git clone https://github.com/teityura/terraform-project.git "${project_name}"
cd "${project_name}/"

# Deploy
make setup
vim terraform.tfvars
vim site.yml
make

# Destroy
make clean
```
