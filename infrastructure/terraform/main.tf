terraform {
  backend "s3" {
    bucket  = "terraform-state-discord-webhook-server"
    key     = "terraform.tfstate"
    encrypt = true
    region  = "us-east-1"
    profile = "discord-server"
  }
}

provider "heroku" {
  email   = var.heroku_email
  api_key = var.heroku_api_key
}

locals {
  heroku_enviorment_vars = {
    WEBHOOK_URL = var.heroku_enviorment_vars["webhook_url"]
  }
}


resource "heroku_app" "discord-webhook-server" {
  name                  = var.app_name
  region                = var.app_region
  sensitive_config_vars = var.heroku_enviorment_vars
  stack                 = var.heroku_stack
}

resource "heroku_build" "discord-webhook-server" {
  app_id = heroku_app.discord-webhook-server.id

  source {
    url     = var.code_source_url
    version = var.app_version
  }


  lifecycle {
    create_before_destroy = true
  }
}

resource "heroku_formation" "discord-webhook-server" {
  app_id     = heroku_app.discord-webhook-server.id
  type       = var.dyno_type
  quantity   = var.app_quantity
  size       = var.dyno_size
  depends_on = [heroku_build.discord-webhook-server]
}

resource "heroku_app_release" "discord-webhook-server" {
  app_id  = heroku_app.discord-webhook-server.id
  slug_id = heroku_slug.discord-webhook-server.id
}

resource "heroku_slug" "discord-webhook-server" {
  app_id                         = heroku_app.discord-webhook-server.id
  file_url                       = var.code_source_url
  buildpack_provided_description = "heroku/python"
  process_types = {
    web = "gunicorn -w 4 -k uvicorn.workers.UvicornWorker src.server:app"
  }
}
