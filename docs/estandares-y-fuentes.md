# Estándares y fuentes (verificadas el 3 de noviembre de 2026)

Cada enlace es documentación oficial. Lo que no pude confirmar está marcado como **no confirmado**.

## Identidad de cargas de trabajo en AWS

| Tema | Fuente |
|---|---|
| Claims del token OIDC de GitHub y `sub` inmutable (desde el 15-jul-2026) | https://docs.github.com/en/actions/reference/security/oidc · https://github.blog/changelog/2026-04-23-immutable-subject-claims-for-github-actions-oidc-tokens/ |
| GitHub Actions con AWS por OIDC | https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-aws |
| Rol de IAM para el proveedor OIDC de GitHub | https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html |
| IAM ya no requiere thumbprint para GitHub | https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html |
| Claims de GitHub como claves de condición de IAM (feb-2026) | https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_iam-condition-keys.html |
| `AssumeRoleWithWebIdentity` y límites | https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRoleWithWebIdentity.html |
| Session tags | https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html |
| *Confused deputy* | https://docs.aws.amazon.com/IAM/latest/UserGuide/confused-deputy.html |
| Permissions boundaries | https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html |
| SCP y RCP | https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html · https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_rcps.html |
| Lógica de evaluación de políticas | https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html |
| Verificaciones de políticas de Access Analyzer | https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-reference-policy-checks.html |
| Eventos de CloudTrail para STS | https://docs.aws.amazon.com/IAM/latest/UserGuide/cloudtrail-integration.html |
| Acción oficial `configure-aws-credentials` | https://github.com/aws-actions/configure-aws-credentials |

## Identidad en Kubernetes

| Tema | Fuente |
|---|---|
| IRSA | https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html |
| EKS Pod Identity | https://docs.aws.amazon.com/eks/latest/userguide/pod-identities.html |
| Comparación y recomendación de AWS | https://docs.aws.amazon.com/eks/latest/best-practices/identity-and-access-management.html |
| ROSA con hosted control planes (roles de IAM y STS) | https://docs.redhat.com/en/documentation/red_hat_openshift_service_on_aws/4/html/introduction_to_rosa/rosa-hcp-about-iam-resources |
| `ValidatingAdmissionPolicy` (estable desde Kubernetes 1.30) | https://kubernetes.io/docs/reference/access-authn-authz/validating-admission-policy/ — **no confirmado** que esté habilitada en EKS en la nube |

## Cadena de suministro

| Tema | Fuente |
|---|---|
| SLSA v1.2 y niveles de Build | https://slsa.dev/spec/v1.2/build-requirements |
| Sigstore y cosign keyless | https://docs.sigstore.dev/cosign/signing/overview/ |
| Kyverno `ImageValidatingPolicy` | https://kyverno.io/docs/policy-types/image-validating-policy/ |
| Amazon ECR y AWS Signer (Notation) | https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-signing.html |
| Attestations de GitHub y SLSA | https://docs.github.com/en/actions/concepts/security/artifact-attestations |
| NIST SSDF (SP 800-218 v1.1, final; v1.2 sigue en borrador) | https://csrc.nist.gov/pubs/sp/800/218/final |
| AWS Security Reference Architecture | https://docs.aws.amazon.com/prescriptive-guidance/latest/security-reference-architecture/introduction.html |
| Amazon EKS Best Practices Guide | https://docs.aws.amazon.com/eks/latest/best-practices/introduction.html |

## Cosas que cambiaron y conviene saber

- **15-jul-2026:** los repositorios nuevos de GitHub emiten el `sub` inmutable con IDs.
- **2-dic-2026:** GitHub bloqueará `pull_request_target` por defecto en repositorios públicos (con pruebas de apagón el 9 y 16 de noviembre).
- **Kyverno 1.19:** `ClusterPolicy` está deprecada y se elimina en la 1.20.
- **Cosign 3.x:** el formato bundle es el predeterminado.
- **OMB M-22-18 y M-23-16** fueron rescindidos el 23-ene-2026 (OMB M-26-05): el formulario de attestation del SSDF ya no es obligatorio por esa vía.
