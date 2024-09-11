# Provider Configuration
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id  # Reference from variables
  client_id       = "625922cb-f5e3-4be6-8f56-f63f10cd3915"  # Use the appId from the output
  client_secret   = "aWq8Q~Sw_CYFbDolJRju6QbqLKFpzydrC3Urb6R"  # Use the password from the output
  tenant_id       = "82676786-5bc7-43c6-b8f8-b3ee02b0b5f3"  # Use the tenant from the output
  resource_provider_registrations = "none"  # Prevent automatic resource provider registration
}
