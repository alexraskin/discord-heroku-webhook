variable "heroku_email" {
  type    = string
  default = "Heroku account email"
}

variable "heroku_api_key" {
  type        = string
  description = "Heroku API Key"
}

variable "app_name" {
  type        = string
  description = "The name of the Heroku app"
}

variable "app_region" {
  type        = string
  description = "The region to deploy the app to"
}


variable "app_quantity" {
  default     = 1
  description = "Number of dynos in your Heroku formation"
}

variable "heroku_enviorment_vars" {
  type        = map(string)
  description = "Environment variables for Heroku app"
}

variable "app_version" {
  type        = string
  description = "Version of the app"
}

variable "heroku_stack" {
  type        = string
  description = "Stack for your Heroku app"
}

variable "dyno_type" {
  type        = string
  description = "Type of dyno"
}

variable "dyno_size" {
  type        = string
  description = "Size of dyno"
  default     = "free"
}

variable "code_source_url" {
  type = string
}
