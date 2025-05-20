# Arquitetura Híbrida XPTO — Resumo Executivo

Este documento resume a arquitetura proposta para a solução híbrida da empresa XPTO, contemplando a integração segura entre ambiente local (on-premises) e serviços em nuvem (Azure), com foco em automação, segurança, escalabilidade e governança.

---

## Visão Geral

A infraestrutura é composta por:

- **Ambiente On-Premises**
- **Ambiente Cloud Azure**
- **Conectividade via VPN Site-to-Site**
- **Deploy automatizado via Azure DevOps + Terraform**

---

## On-Premises

### Identidade e Acesso
- Active Directory com autenticação LDAP e MFA
- Integração com Azure AD Connect

### Computação
- VM principal com Serviço de Controle de Lançamentos
- VM secundária (standby) para failover manual

### Banco e Armazenamento
- PostgreSQL em modo read-only (replicado da cloud)
- SSD local + backup incremental automatizado

### Segurança
- Firewall UTM, IPTables, SSH Hardening
- DNS local e Load Balancer interno
- Monitoramento com Zabbix

### Automação
- Ansible para provisionamento, backup e agendamento de tarefas

---

## Azure Cloud

### Rede e Conectividade
- VNet com 3 subnets: `app`, `data`, `gateway`
- Azure VPN Gateway com IPsec para integração on-prem

### Aplicações
- Azure Kubernetes Service (AKS) com imagens via ACR
- Azure Application Gateway com TLS + WAF
- Azure API Management (APIM)
- Azure Function Apps (tarefas assíncronas/eventos)

### Dados e Armazenamento
- Azure PostgreSQL Flexible Server com backup automático
- Azure Cache for Redis (TLS ativado)
- Azure Storage Account para blobs e arquivos

### Segurança
- Azure Key Vault para gerenciamento de segredos
- Network Security Groups (NSG) + Azure Firewall
- Aplicação de política de tags e naming convention

---

## Monitoramento e Observabilidade

| Serviço                      | Finalidade                              |
|-----------------------------|------------------------------------------|
| Azure Monitor               | Coleta de métricas                       |
| Log Analytics Workspaces    | Centralização de logs                    |
| Application Insights        | Telemetria das aplicações                |
| Alerts                      | Notificações via email, Teams, SMS,|
| Zabbix                      | Monitoramento local do ambiente on-prem |

---

## CI/CD com Azure DevOps

- Repositório de código IaC (Terraform + YAML)
- Pipelines de validação, `plan`, `apply` manuais
- Deploy controlado por ambiente (`dev`, `stg`, `prod`)
- Integração com Boards, Artefatos, Key Vault
- Controle de versão e aprovação via GitOps

---

## Naming Convention

Exemplo de padrão aplicado:

[projeto]-[tipo]-[ambiente]-[região]

Ex: xpto-aks-prod-brazilsouth

Todos os recursos possuem:
- Tags obrigatórias (`project`, `env`, `owner`, `costcenter`, `managed_by`)
- Identificação por ambiente e localização
- Organização modular via Terraform

---

## Benefícios Atendidos

- Alta disponibilidade e failover planejado
- Segurança multicamada (AD, NSG, WAF, MFA)
- Governança com naming convention e tags
- Observabilidade fim a fim
- Automação robusta (Terraform, Ansible, CI/CD)
- Conectividade estável entre ambientes

---