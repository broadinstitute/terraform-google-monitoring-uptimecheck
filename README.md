# terraform-google-monitoring-uptimecheck

## Usage

```terraform
module "uptimecheck-example-com" {
  source  = "kenju/monitoring-uptimecheck/google"
  version = "0.1.0"
  project = "foo"
  host    = "example.com"
  path    = "/"
  notification_channels = [
    google_monitoring_notification_channel.foo.id,
  ]
}

resource "google_monitoring_notification_channel" "foo" {
  display_name = "Foo"
  type         = "slack"
  labels = {
    "channel_name" = "#foo"
    "auth_token"   = ""
  }
}
```
