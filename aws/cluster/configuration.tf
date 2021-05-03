module "configuration" {
  source = "../../common/configuration"

  configuration = var.configuration
  base_key      = var.configuration_base_key
}

locals {
  # current workspace config
  cfg = module.configuration.merged[terraform.workspace]

  name_prefix = local.cfg["name_prefix"]

  base_domain = local.cfg["base_domain"]

  cluster_availability_zones_lookup = lookup(local.cfg, "cluster_availability_zones", "")
  cluster_availability_zones        = split(",", local.cluster_availability_zones_lookup)

  cluster_instance_type = local.cfg["cluster_instance_type"]

  cluster_desired_capacity = local.cfg["cluster_desired_capacity"]

  cluster_max_size = local.cfg["cluster_max_size"]

  cluster_min_size = local.cfg["cluster_min_size"]

  syslog_instance_type = local.cfg["syslog_instance_type"]

  syslog_desired_capacity = local.cfg["syslog_desired_capacity"]

  syslog_max_size = local.cfg["syslog_max_size"]

  syslog_min_size = local.cfg["syslog_min_size"]

  worker_root_device_volume_size = lookup(local.cfg, "worker_root_device_volume_size", null)
  worker_root_device_encrypted   = lookup(local.cfg, "worker_root_device_encrypted", null)

  cluster_aws_auth_map_roles    = lookup(local.cfg, "cluster_aws_auth_map_roles", "")
  cluster_aws_auth_map_users    = lookup(local.cfg, "cluster_aws_auth_map_users", "")
  cluster_aws_auth_map_accounts = lookup(local.cfg, "cluster_aws_auth_map_accounts", "")

  manifest_path_default = "manifests/overlays/${terraform.workspace}"
  manifest_path         = var.manifest_path != null ? var.manifest_path : local.manifest_path_default

  disable_default_ingress = lookup(local.cfg, "disable_default_ingress", false)

  enabled_cluster_log_types_lookup = lookup(local.cfg, "enabled_cluster_log_types", "api,audit,authenticator,controllerManager,scheduler")
  enabled_cluster_log_types        = split(",", local.enabled_cluster_log_types_lookup)

  disable_openid_connect_provider = lookup(local.cfg, "disable_openid_connect_provider", false)
}
