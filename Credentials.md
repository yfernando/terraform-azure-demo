
# Azure credentials for the Terraform `azurerm` provider.

You need the following credentilas to run Terraform on Azure.
```
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"

}
```

## What is Service Principal ?

You most likely do not want to run your Terraform script under your own credentials. Instead, you create an identity for the application (i.e. Terraform) that includes authentication credentials and role assignments. This is called  a `service principal` in Azure lingo. More details [here.](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-authenticate-service-principal)


### Create a Service Principal

There are two high-level tasks to do.

1. Create an App Registration with `Azure Active Directory`.
2. Grant necessary permissions for the App Registration in your `Azure Subscription(IAM)`.


##### Using Azure ARM Portal

<!-- You can do this via [Azure ARM portal](http://portal.azure.com) as described [here](https://www.terraform.io/docs/providers/azurerm/). -->

[You can use Azure ARM portal to create a service principal that can access resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal). Refer section `Create an Active Directory application`.


##### Using Azure CLI

[You can also use the Azure CLI to create a service principal to access resources.](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-authenticate-service-principal-cli#provide-credentials-through-azure-cli)

Summary:

1. Get Azure-CLI (assuming Mac for now)
  ```
  $ brew install azure-cli
  ```

2. Login to your Azure subscription
  ```
  $ azure login
  ```
  > If 2FA, do as per the `info` on the command line
  > ```
  > info:    Executing command login
  > \info:    To sign in, use a web browser to open the page https://aka.ms/devicelogin and enter the code ABC9E9GHI to authenti
  > ```
  > If 2FA is succesfull, should return:
  > ```
  > info:    Added subscription {guid}
  > info:    Added subscription {guid}
  > info:    login command OK
  > ```

3. Create the AD application and service principal
  ```
  $ azure ad sp create -n {your-application} -p {your-password}
  ```
  i.e. `your-application` = `terraform`

  Which returns:
  ```
  + Creating application terraform
  + Creating service principal for application {guid}
  data:    Object Id:        {guid}
  data:    Display Name:     terraform
  data:    Service Principal Names:
  data:                             e479ef33-6a9a-4d9a-ba62-a95b5e8fed2f
  data:                             http://terraform
  info:    ad sp create command OK
  ```


### Get credentials for the Terraform `azurerm` provider

Once a `service principal` has been created, you can get the credentials needed to run Terraform on Azure.

1. To get `subscription_id` and `tenant_id`, use:
  ```
  $ azure account show
  ```

  Which returns:
  ```
  info:    Executing command account show
  data:    Name                        :
  data:    ID                          : {subscription_id>
  data:    State                       :
  data:    Tenant ID                   : {tenant_id}
  data:    Is Default                  :
  data:    Environment                 :
  data:    Has Certificate             :
  data:    Has Access Token            :
  data:    User name                   :
  data:
  info:    account show command OK
  ```

2. To get `client_id`, use:
  ```
  $ azure ad sp show -c terraform -v
  ```

  Which returns:
  ```
  info:    Executing command ad sp show
  verbose: Getting Active Directory service principals
  data:    Object Id:               1e5e442e-9dcb-468f-8de9-0d8809dfe387
  data:    Display Name:            terraform
  data:    Service Principal Names:
  data:                             https://{org}.onmicrosoft.com/ca8e6243-cc3f-4721-b557-292erte34
  data:                             9f123456-9bf3-4cab-8554-ee3c5a12345
  ```

  The value to use for `client_id` is the `{guid}` listed in the `service principal names.` i.e. `9f123456-9bf3-4cab-8554-ee3c5a12345`

3. For the `client_secret`, use the `password` you gave when creating the AD application above.


### Log in as the `service principal` through Azure CLI (non terraform)

  ```
  azure login -u {client_id} --service-principal --tenant {tenant-id}
  ```

  You will be prompted for the password. Provide the password you specified when creating the AD application.

  You are now authenticated as the service principal for the AD application that you created.
