# Terraform-Azure-Demo
This project is to demo how infrastructure can be setup and managed as code (IaC) on Azure using Terraform.

This demo usese Azure Resource Manager (ARM) API and the corresponding Terraform provider [`azurerm`](https://www.terraform.io/docs/providers/azurerm/) to interact with many resoruces provided by Azure.

Altough Azure still support its old Service Manager (Classic) API, the corresponding Terraform provider [`azure`](https://www.terraform.io/docs/providers/azure/) is no longer being actively supported by HashiCorp, hence not used in this demo.

## Why Terraform?

I believe Terraform is a `great unifier` and gives you the freedom to be agnostic of any Cloud platform. Especially, when writing Infrastructure-as-Code (IaC) to build and manage the underpinning infrastructure before provisioning any software.

Terraform's approach is to be 'declarative' and always create 'immutable' infrastructure as described [here]('https://blog.gruntwork.io/why-we-use-terraform-and-not-chef-puppet-ansible-saltstack-or-cloudformation-7989dad2865c#.4lcmgqvel')

What about `state`? Well, yes you need some kind of wrapper to manage the state. But there are ways and means ;)

This demo shares the code as I go through the phases of learning and mastering Terraform. Enjoy and PR it if you care!

## Getting Started

[AzureCLI](https://azure.github.io/projects/clis/) is used to get the inital credentials. Yet the intention is *not* to use any Azure Poweshell modules in this demo.

### Prerequisites

### Dependencies
