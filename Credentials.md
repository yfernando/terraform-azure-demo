
# Azure credentials for the Terraform `azurerm` provider.

You need the following credentilas to run Terraform on Azure.
```
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"

}
```

## The Service Principal

You most likely do not want to run your Terraform script under your own credentials. Instead, you create an identity for the application (i.e. Terraform) that includes authentication credentials and role assignments. This is called  a  [`service principal`.](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-authenticate-service-principal)


### Create a Service Principal

There are two high-level tasks to complete.

1. Create an App Registration with Azure Active Directory.
2. Grant permissions for the Application Registration in your Subscription.

#### Using Azure ARM Portal

You can do this in either via [Azure ARM portal] as described [here](https://www.terraform.io/docs/providers/azurerm/).

#### Using Azure CLI

Login to you Azure subscription to get the `subscription_id` and `tenant_id` using the Azure CLI.

1. Get Azure-CLI
```
$ brew install azure-cli
```
2. Login
```
$ azure login
```

3. 2FA - Do as it says on the command line.
```
info:    Executing command login
\info:    To sign in, use a web browser to open the page https://aka.ms/devicelogin and enter the code ABC9E9GHI to authenticate.
```
If your 2FA is succesfull, you will someting similar to..
```
\info:    Added subscription <subscription - 1>
info:    Added subscription <subscription - 2>
+
info:    login command OK
```

4. Swith to Azure Resource Manager (ARM) mode
```
$ azure config mode arm
info:    Executing command config mode
info:    New mode is arm
info:    config mode command OK
```

5. Show account details to get `SUBSCRIPTION ID` and `TENANT ID`
```
$ azure account show
info:    Executing command account show
data:    Name                        :
data:    ID                          : <SUBSCRIPTION ID>
data:    State                       :
data:    Tenant ID                   : <TENANT ID>
data:    Is Default                  :
data:    Environment                 :
data:    Has Certificate             :
data:    Has Access Token            :
data:    User name                   :
data:
info:    account show command OK
```

6. Get `client_id` and `client_secret` (password)

TBD
