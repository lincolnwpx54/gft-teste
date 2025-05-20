# Plano de Disaster Recovery (DR)

## Objetivo

Este plano de recuperação de desastres tem como objetivo garantir a **continuidade operacional** dos serviços da empresa XPTO em cenários de falhas críticas, indisponibilidade de componentes ou desastres em data centers locais ou na nuvem.

---

## Conceitos Fundamentais

| Termo | Definição |
|-------|-----------|
| **RTO (Recovery Time Objective)** | Tempo máximo aceitável para a restauração do serviço após uma falha. |
| **RPO (Recovery Point Objective)** | Máximo de dados que pode ser perdido (em tempo) durante um incidente. |

---

## Metas de Recuperação

| Serviço                    | RTO       | RPO       |
|----------------------------|-----------|-----------|
| Controle de Lançamentos    | 15 minutos | 5 minutos |
| Serviço de Consolidação    | 10 minutos | 1 minuto  |
| Banco de Dados             | 10 minutos | < 1 minuto (PITR) |
| Cache Redis                | 5 minutos  | não crítico |
| API Gateway e Load Balancer| 2 minutos  | não aplicável |

---

## 🧱 Estratégias Adotadas

### 🔹 Banco de Dados

- Utilização de serviço gerenciado com suporte a:
  - **Backups automáticos**
  - **PITR (Point-in-time recovery)**
  - **Replicação multi-zona**
- Read replica on-premises para contingência em falhas de conectividade com a nuvem.

### 🔹 Serviços Cloud (Consolidação)

- Executados em **Kubernetes gerenciado** com autoescalabilidade.
- Replica pods automaticamente em múltiplas zonas.
- **Reimplantações automatizadas** em caso de falhas de instância.
- **Readiness e Liveness probes** para detectar falhas internas.

### 🔹 Serviços On-Premises (Lançamentos)

- VM principal com monitoramento ativo (Zabbix, Prometheus).
- Failover manual ou automatizado para **VM standby** local.
- Backups em disco externo e upload diário para nuvem.

### 🔹 Cache (Redis)

- Redis gerenciado com failover automático.
- Dados temporários; não impacta em consistência de negócios em caso de perda.

---

## 🌐 Comunicação e Failover

- Conexão **VPN Site-to-Site** redundante com failover automático entre túneis.
- Cloud Load Balancers com **health checks** para direcionamento de tráfego.
- Uso de **DNS com TTL curto** para redirecionamento rápido em falhas regionais (ex: Route 53 ou Cloud DNS).

---

## 📑 Procedimentos de Recuperação

### 🧯 Em caso de falha no on-premises:
1. Redirecionar DNS para versão na nuvem (se disponível).
2. Promover VM standby (backup local).
3. Restaurar dados a partir de backup incremental diário.

### ☁️ Em caso de falha na cloud:
1. Redistribuir tráfego via backup DNS.
2. Ativar leitura da réplica local do banco de dados.
3. Executar serviços críticos locais temporariamente, com limitação funcional.

---

## 🔄 Testes e Simulações

- Testes de restauração são realizados trimestralmente.
- Simulações de falhas parciais (ex: perda de zona de disponibilidade).
- Documentação dos planos de resposta com responsáveis por cada etapa.

---

## 📘 Registro e Comunicação

- Logs de incidentes armazenados e enviados para sistema de SIEM (ex: ELK, Cloud Logging).
- Comunicação de falhas via Slack/Email com acionamento automático (ex: via PagerDuty ou Opsgenie).
- Templates de comunicação para equipe técnica e stakeholders.

---

## 🛠️ Ferramentas Suporte ao DR

- **Terraform**: recriação rápida de ambientes via infraestrutura como código.
- **Ansible**: configuração e aplicação rápida de servidores locais.
- **Cloud Backup** (RDS, GCS, S3): retenção automática com política de retenção.
- **Zabbix / Prometheus**: detecção proativa de falhas.
- **Grafana**: visibilidade em tempo real dos indicadores de saúde do sistema.

---

## 🔄 Evoluções Futuras

- Implantação de **runbooks automatizados** com Lambda/Cloud Functions para failover.
- Adoção de **Service Mesh + Circuit Breaker** para lidar com falhas em chamadas entre microserviços.
- Integração com **DRaaS (Disaster Recovery as a Service)** em nuvens públicas.

---

