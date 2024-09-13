# Provider Configuration
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id  # Reference from variables
  client_id       = "57cb040a-c18e-4bd6-8cea-669b1b830cca"  # Use the appId from the output
  client_secret   = "pfM8Q~ZytkiK2~VksVfRsEnUrlVbBhXo6UMbJb41"  # Use the password from the output
  tenant_id       = "82676786-5bc7-43c6-b8f8-b3ee02b0b5f3"  # Use the tenant from the output
  resource_provider_registrations = "none"  # Prevent automatic resource provider registration
}
