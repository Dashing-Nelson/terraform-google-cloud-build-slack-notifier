variable "project_id" {
  description = "Project ID of the project in which Cloud Build is running."
  type        = string
}

variable "name" {
  description = "The name to use on all resources created."
  type        = string

  validation {
    condition     = can(regex("[a-z0-9-]{0,20}", var.name))
    error_message = "A name must be lowercase letters, numbers, or -."
  }
}

variable "slack_webhook_url_secret_id" {
  description = "The ID of an existing Google Secret Manager secret, containing a Slack webhook URL. This is usually the `id` from the output of a `google_secret_manager_secret` resource."
  type        = string
}

variable "slack_webhook_url_secret_project" {
  description = "The project ID containing the slack_webhook_url_secret_id."
  type        = string
}

variable "region" {
  description = "The region in which to deploy the notifier service."
  type        = string
  default     = "us-central1"
}

# See: https://cloud.google.com/build/docs/configuring-notifications/configure-slack#using_cel_to_filter_build_events
variable "cloud_build_event_filter" {
  description = "The CEL filter to apply to incoming Cloud Build events."
  type        = string
  default     = "build.substitutions['BRANCH_NAME'] == 'main' && build.status in [Build.Status.SUCCESS, Build.Status.FAILURE, Build.Status.TIMEOUT]"
}

variable "cloud_build_notifier_image" {
  description = "The image to use for the notifier."
  type        = string
  default     = "us-east1-docker.pkg.dev/gcb-release/cloud-build-notifiers/slack:latest"
}

# https://cloud.google.com/build/docs/configuring-notifications/configure-slack#configuring_slack_notifications (see slack.json under number 7)
# The default slack.json will be used if this is not provided.
variable "override_slack_template_json" {
  description = "Custom template to use for the Slack notifications, which overrides the default."
  type        = string
  default     = ""
}

variable "disable_services_on_destroy" {
  description = "If true, the service APIs used will be disabled on destroy."
  type        = bool
  default     = false
}
