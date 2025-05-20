# Estratégia de Automação — IaC com Terraform e Ansible

## Objetivo

Automatizar o provisionamento, configuração e manutenção da infraestrutura híbrida, garantindo **padronização, rastreabilidade, reprodutibilidade** e **agilidade**. A automação também contribui diretamente para as estratégias de segurança, FinOps e governança.

---

## Ferramentas Utilizadas

| Ferramenta  | Finalidade                                                                 |
|-------------|-----------------------------------------------------------------------------|
| **Terraform** | Provisionamento de recursos na nuvem (VMs, rede, bancos, containers, etc.) |
| **Ansible**   | Configuração pós-provisionamento e automação em ambientes on-premises e cloud |

---

## Aplicações com Terraform

Terraform será usado para provisionar:

- Rede VPC/Subnets
- Instâncias de VM (ambientes de dev, staging e prod)
- Clusters Kubernetes (EKS, GKE, AKS)
- Load Balancer + Auto Scaling Group
- Banco de dados gerenciado (RDS, CloudSQL)
- Cache Redis (gerenciado)
- API Gateway e VPN Site-to-Site

### Estrutura do Projeto

```text
infra/
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── network/
│   ├── compute/
│   ├── kubernetes/
│   ├── database/
│   └── monitoring/
└── environments/
    ├── dev/
    └── prod/

