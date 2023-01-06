variable "roles_list" {
    type = list(string)
    default = [ "roles/container.hostServiceAgentUser", "roles/compute.securityAdmin",]
}
#Host Service Agent User and Compute Security Admin.

resource "google_project_iam_member" "sa-with-roles01" {
    project = "practice-project-364006"
    for_each = toset(var.roles_list)
    member = "serviceAccount:service-163915593947@container-engine-robot.iam.gserviceaccount.com"
    role = each.key
}

 # Kubernetes Engine Service Agent role.

resource "google_project_iam_member" "sa-with-roles02" {
    project = "serviceproject-pji"
    role = "roles/container.serviceAgent"
    member = "serviceAccount:service-163915593947@container-engine-robot.iam.gserviceaccount.com"

}

# Compute Network User

resource "google_project_iam_binding" "binding-with-host" {
    project = "practice-project-364006"
    role    = "roles/compute.networkUser"
    members = [
        "serviceAccount:service-163915593947@container-engine-robot.iam.gserviceaccount.com",
        "serviceAccount:163915593947@cloudservices.gserviceaccount.com",
    ]

}