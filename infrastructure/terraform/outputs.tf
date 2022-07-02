output "app_url" {
  value = heroku_app.discord-webhook-server.web_url
}

output "app_name" {
  value       = heroku_app.discord-webhook-server.name
  description = "Application name"
}

output "app_region" {
  value       = heroku_app.discord-webhook-server.region
  description = "Application region"
}

output "app_stack" {
  value       = heroku_app.discord-webhook-server.stack
  description = "Application stack"
}

output "release_id" {
  value       = heroku_app_release.discord-webhook-server.id
  description = "Release ID"
}

output "status" {
  value       = heroku_build.discord-webhook-server.status
  description = "Application status"
}