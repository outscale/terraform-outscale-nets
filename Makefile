fmt:
	terraform fmt -recursive

validate: fmt
	terraform init
	terraform validate

readme: fmt
	terraform-docs markdown table --output-file README.md --output-mode inject .
