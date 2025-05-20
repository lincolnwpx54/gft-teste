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

Terraform será usado para provisionar os principais componentes da infraestrutura no Azure:

- **Azure Virtual Network (VNet)** com subnets segregadas (app, dados, gateway)
- **Instâncias de VM** (para ambientes locais simulados, dev/stg/prod, se necessário)
- **Cluster Kubernetes** com **Azure Kubernetes Service (AKS)**
- **Azure Application Gateway** com WAF e TLS
- **Azure PostgreSQL Flexible Server**, com backup automático e alta disponibilidade
- **Azure Cache for Redis**, com conexão privada e TLS ativado
- **Azure API Management (APIM)** para controle de chamadas e segurança de APIs
- **Azure VPN Gateway** para conexão site-to-site com o ambiente on-premises
- **Azure Key Vault**, **Log Analytics**, **Storage Accounts**, entre outros recursos auxiliares

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
