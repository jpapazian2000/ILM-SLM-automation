# Deployment of HCP Boundary linked with HCP Vault

## Content
1. [hcp-resources](https://github.com/hashicorp/ILM-SLM-automation/tree/main/hcp-resources) : Deploy and HVN, HCP Vault and HCP Boundary.
2. [tfc-config](https://github.com/hashicorp/ILM-SLM-automation/tree/main/tfc-config) : Deploy TFC resources such as workspaces and var sets for dynamic creds etc...
3. [aws-infra](https://github.com/hashicorp/ILM-SLM-automation/tree/main/aws-infra) : Deploy landing zone on AWS.
4. [vault-config](https://github.com/hashicorp/ILM-SLM-automation/tree/main/vault-config) : Configure ACLs, Auth Methods and Secrets engines for HCP Boundary integration.
5. [aws-ec2](https://github.com/hashicorp/ILM-SLM-automation/tree/main/aws-ec2) : Deploy EC2 resources on AWS to configure as targets.
6. [boundary-config](https://github.com/hashicorp/ILM-SLM-automation/tree/main/boundary-config) : Configure Boundary components, Scopes, Principals, Targets, Host Catalogs, Host sets, Hosts, Credential libraries, credential stores, workers etc...
7. [packer-images](https://github.com/hashicorp/ILM-SLM-automation/tree/main/packer-images) : An example of packer image to use for AWS EC2.