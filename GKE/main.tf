module "subnet-iam-bindings" {
  source = "terraform-google-modules/iam/google//modules/subnets_iam"
  subnets        = ["my-subnet_one", "my-subnet_two"]
  subnets_region = "my-region"
  project        = "host-project"
  mode           = "authoritative"

  bindings = {
    "roles/compute.networkUser" = [
      "serviceAccount:${service-account-created-in-service-project}",
      "serviceAccount:service-859146099701@container-engine-robot.iam.gserviceaccount.com",
      "serviceAccount:859146099701@cloudservices.gserviceaccount.com",
    ]
  }
}

module "project-iam-bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  projects = ["host-project"]
  mode     = "additive"

  bindings = {
    "roles/container.hostServiceAgentUser" = [
      "serviceAccount:service-859146099701@container-engine-robot.iam.gserviceaccount.com",
    ]
  }
}


module "gke" {
  source              = "../module/gke"
  name                = "guc1-gke-sandbox-shared-jenkins-cd"
  remove_default_pool = true
  cluster_ip          = "10.32.0.0/21"
  service_ip          = "10.35.240.0/27"
  network             = "projects/practice-project-364006/global/networks/default"
  node_locations = [
    "us-central1-a",
    "us-central1-b",
    "us-central1-c",
  ]
  project                       = "practice-project-364006"
  subnetwork                    = "projects/practice-project-364006/regions/us-central1/subnetworks/default"
  dataset_id                    = "jenkins_cd"
  resource_consumption_metering = true
  master_ip_range               = "172.16.0.0/28"
  private_node                  = true
  private_endpoint              = true
  master_global_access          = true
  master_auth_cidr              = "172.16.0.0/28"
  master_version                = "1.22.12-gke.1200"
  location                      = "us-central1"
  http_load_balancer            = false
  gce_perst_disk_csi_driver     = false
  filestore_csi_driver          = false
  network_pol_confg             = true
  dns_cache_confg               = true
  config_connector              = false
  gke_backup                    = false
  cloudrun_config               = true
  binary_auth                   = false
  cluster_autoscaling           = false
  preemptible                   = false
  networking_mode               = "VPC_NATIVE"
  profile                       = "BALANCED"
  database_encrypt              = "DECRYPTED"
  snat_status                   = true
  log_config                    = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  issue_client_cert             = false
  monitoring_config             = ["SYSTEM_COMPONENTS", ]
  release_channel               = "UNSPECIFIED"
  managed_prometheus            = false
  network_policy                = false
  topic                         = "projects/practice-project-364006/topics/notification-update"
  events                        = ["UPGRADE_EVENT", ]
  nodepool_name                 = "guc1-gke-sandbox-shared-jenkins-cd"
  image_type                    = "COS_CONTAINERD"
  machine_type                  = "n1-standard-4"
  disk_type                     = "pd-standard"
  disk_size                     = 100
  auto_repair                   = true
  auto_upgrade                  = true
  max_surge                     = 1
  max_unavailable               = 0
  min_node                      = 1
  max_node                      = 5
  sa_name                       = "gke-test-sa"
  roles_list = ["roles/logging.logWriter", "roles/monitoring.metricWriter", "roles/monitoring.viewer",
    "roles/source.reader", "roles/monitoring.editor", "roles/storage.objectViewer",
  ]
  gke_metadata_server  = true
  integrity_monitoring = true
  secure_boot          = false
  oauth_scopes = ["https://www.googleapis.com/auth/devstorage.read_write",
    "https://www.googleapis.com/auth/service.management",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/monitoring",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/compute",
  ]
  cluster_resource_labels = {
    domain      = "shared",
    environment = "non-prod"
  }
  vertical_pod_autoscaling = true
  start_time               = "2019-01-01T00:30:00Z"
  end_time                 = "2019-01-01T04:30:00Z"
  recurrence               = "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"

}