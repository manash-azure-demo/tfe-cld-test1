# Provider Configuration
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id  # Reference from variables
  client_id       = "88232260-8632-4f72-bb9c-d7d64a62a3d4"  # Use the appId from the output
  client_secret   = "hMP8Q~dBEubY0i5e2MUII1miQp8NUsmO6Q5YGbf3"  # Use the password from the output
  tenant_id       = "82676786-5bc7-43c6-b8f8-b3ee02b0b5f3"  # Use the tenant from the output
  resource_provider_registrations = "none"  # Prevent automatic resource provider registration
}
