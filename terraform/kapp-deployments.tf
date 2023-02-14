resource "kubernetes_namespace" "gitops" {
  metadata {
    name = "gitops"
  }
}

resource "kubernetes_cluster_role_binding" "gitops-default-sa-installer" {
  metadata {
    name = "gitops-default-sa-installer"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "tanzupackage-install-admin-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = kubernetes_namespace.gitops.metadata[0].name
  }
}

resource "kubernetes_secret" "cluster-install-secrets" {
  metadata {
    name = "cluster-install-secrets"
    namespace = kubernetes_namespace.gitops.metadata[0].name
  }
  data = {
    "inline-values" : <<EOF
      tanzunet_username: ${var.tanzunet_username}
      tanzunet_password: ${var.tanzunet_password}
      git_client_id: ${var.git_client_id}
      git_client_secret: ${var.git_client_secret}
      azure_storage_account_key: ${azurerm_storage_account.tap.primary_access_key}
      domain: ${var.project_name}.${data.azurerm_dns_zone.dns.name}
      azure:
        tenant_id: ${data.azurerm_client_config.current.tenant_id}
        subscription_id: ${data.azurerm_client_config.current.subscription_id}
        external_dns:
          resource_group: ${data.azurerm_resource_group.dns.name}
          client_id: ${azuread_application.external_dns.application_id}
          client_secret: ${azuread_application_password.external_dns.value}
    EOF
  }
}

resource "kubectl_manifest" "kapp-gitops-app" {
  depends_on = [
    tanzu-mission-control_cluster.attach_aks_cluster_with_kubeconfig, 
    kubernetes_cluster_role_binding.gitops-default-sa-installer,
    kubernetes_namespace.gitops,
    azurerm_role_assignment.resource_group_reader,
    azurerm_role_assignment.dns_contributer]
  wait = true
  yaml_body  = <<YAML
    apiVersion: kappctrl.k14s.io/v1alpha1
    kind: App
    metadata:
      name: cluster-installs
      namespace: ${kubernetes_namespace.gitops.metadata[0].name}
    spec:
      serviceAccountName: default
      fetch:
      - git:
          url: ${var.gitops_repo_url}
          ref: ${var.gitops_repo_ref}
          subPath: ${var.gitops_repo_subPath}
      template:
      - ytt:
          valuesFrom:
          - secretRef:
              name: ${kubernetes_secret.cluster-install-secrets.metadata[0].name}
      deploy:
      - kapp: {}
    YAML
}