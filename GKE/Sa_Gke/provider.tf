provider "google" {
  project = "practice-project-364006"
  #region      = var.region
  credentials = file("gke-perm.json")
}

provider "google-beta" {
  project = "practice-project-364006"
  #region      = var.region
  credentials = file("gke-perm.json")
}
