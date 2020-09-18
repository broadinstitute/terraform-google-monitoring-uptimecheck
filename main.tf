locals {
  url = "${var.host}${var.path}"
}

resource "google_monitoring_uptime_check_config" "uptime-check-config" {
  count            = var.enable ? 1 : 0
  display_name     = local.url
  timeout          = var.timeout
  period           = "900s"
  selected_regions = var.regions
  project          = var.project
  depends_on       = [var.dependencies]

  http_check {
    headers      = {}
    mask_headers = false
    path         = var.path
    port         = "443"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project
      host       = var.host
    }
  }

  timeouts {}

  # allow uptime_check_config to be destroyed if alert policies are linked
  # https://github.com/hashicorp/terraform-provider-google/issues/3133#issuecomment-468783073
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_monitoring_alert_policy" "uptime-check" {
  count      = var.enable ? 1 : 0
  project    = var.project
  depends_on = [var.dependencies]

  display_name          = "uptime check failed for ${local.url}"
  notification_channels = var.notification_channels
  combiner              = "OR"
  conditions {
    display_name = "Uptime Health Check on ${var.host}"
    condition_threshold {
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" resource.type=\"uptime_url\" metric.label.\"check_id\"=\"${basename(google_monitoring_uptime_check_config.uptime-check-config.id)}\""
      duration        = "0s"
      threshold_value = 1
      comparison      = "COMPARISON_GT"
      aggregations {
        alignment_period     = "1200s"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields = [
          "resource.*"
        ]
        per_series_aligner = "ALIGN_NEXT_OLDER"
      }

      trigger {
        count   = 1
        percent = 0
      }
    }
  }

  documentation {
    content   = "https://${local.url}"
    mime_type = "text/markdown"
  }
}
