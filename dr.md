# Plano de Disaster Recovery (DR)

## Objetivo

Este plano visa garantir a **continuidade operacional** dos serviços da empresa XPTO em cenários de falhas críticas, indisponibilidade de componentes ou desastres em data centers locais ou na nuvem (Azure).

---

## Conceitos Fundamentais

| Termo | Definição |
|-------|-----------|
| **RTO (Recovery Time Objective)** | Tempo máximo aceitável para restauração do serviço após falha |
| **RPO (Recovery Point Objective)** | Tempo máximo aceitável de perda de dados (em minutos)          |

---

## Metas de Recuperação

| Serviço                    | RTO       | RPO       |
|----------------------------|-----------|-----------|
| Controle de Lançamentos    | 15 minutos | 5 minutos |
| Serviço de Consolidação    | 10 minutos | 1 minuto  |
| Banco de Dados (PostgreSQL)| 10 minutos | < 1 minuto (PITR) |
| Cache Redis                | 5 minutos  | não crítico |
| API Gateway / App Gateway  | 2 minutos  | não aplicável |

---

## Estratégias Adotadas

### Banco de Dados (Azure PostgreSQL)

- Serviço gerenciado com:
  - **Backup automático com retenção**
  - **Recuperação ponto no tempo (PITR)**
  - **Alta disponibilidade zone-redundant**
- Read-replica local para contingência

### Serviços em Nuvem (Consolidação)

- Implantação no **AKS com múltiplas zonas**
- **Autoescalabilidade (HPA)** e reinício automático de pods
- Liveness/Readiness probes
- Rollback automático via estratégia de deploy do Kubernetes

### Serviços On-Premises (Lançamentos)

- VMs com monitoramento contínuo (Zabbix)
- Failover manual ou automatizado para standby
- Backups locais agendados via Ansible
- Upload dos backups para **Azure Storage Account**

### Cache (Redis)

- **Azure Cache for Redis** gerenciado, com failover interno
- Dados voláteis — não exigem replicação cross-region

---

## Comunicação e Failover

- **Azure VPN Gateway** + **Local Network Gateway**
  - Site-to-site IPsec com failover de túneis
- **Azure Application Gateway** + Health Checks
  - Redirecionamento automático de tráfego
- **Azure DNS** com TTL reduzido para reconfiguração rápida de nomes

---

## Procedimentos de Recuperação

### Falha no On-Premises

1. Redirecionar tráfego para ambiente na nuvem via DNS
2. Promover VM standby se for uma falha parcial
3. Restaurar backup do PostgreSQL local ou conectar à réplica cloud

### Falha na Nuvem (Azure)

1. Redirecionar chamadas críticas para backup DNS (on-prem)
2. Ativar PostgreSQL local como leitura temporária
3. Executar serviços mínimos em ambiente local com limitações

---

## Testes e Simulações

- **Testes de failover semestrais** em cenários controlados
- **Verificação de integridade de backup semanal**
- Simulações de falha parcial (zona de disponibilidade, conexão VPN)
- Checklist técnico com responsáveis nomeados por etapa

---

## Registro e Comunicação

- Logs armazenados via:
  - **Log Analytics Workspace (Azure)**
  - **Zabbix / Syslog (On-Premises)**
- Alertas automáticos via:
  - Microsoft Teams, Email, SMS (via Azure Alerts)
  - Integração com **Opsgenie ou PagerDuty**

---

## Ferramentas Suporte ao DR

| Ferramenta         | Função                             |
|--------------------|------------------------------------|
| **Terraform**      | Recriação de infraestrutura         |
| **Ansible**        | Provisionamento de VMs locais       |
| **Azure Backup**   | Backup automatizado dos dados       |
| **Zabbix**         | Monitoramento de VMs on-prem        |
| **Azure Monitor**  | Observabilidade da nuvem            |
| **Grafana**        | Painéis unificados com alertas      |
| **Azure Key Vault**| Gestão de segredos pós-falha        |

---

## Evoluções Futuras

- Adoção de **Azure Automation Runbooks** para orquestração de failover
- Uso de **Azure Traffic Manager** para distribuição geográfica de DNS
- Implementação de **Azure Site Recovery (ASR)** para VMs críticas on-premises
- Planejamento de DR cross-region para PostgreSQL e AKS

---