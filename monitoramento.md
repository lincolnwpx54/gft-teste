# 📡 Estratégia de Monitoramento e Observabilidade

## 🎯 Objetivo

Garantir **alta visibilidade**, **detecção proativa de falhas** e **resposta rápida a incidentes**, monitorando todos os componentes da infraestrutura híbrida da XPTO, incluindo servidores, containers, rede, banco de dados, aplicações e usuários.

---

## 1. Visão Geral

A estratégia cobre os três pilares da observabilidade:

- **Métricas (Metrics)**
- **Logs**
- **Traces**

Cada componente é integrado a pelo menos uma dessas camadas.

---

## 2. Componentes Monitorados

| Componente               | Métricas             | Logs                      | Alertas              |
|--------------------------|----------------------|----------------------------|----------------------|
| VMs On-Prem              | CPU, RAM, Disco       | Syslog, SSH, sudo          | Zabbix               |
| VPN Site-to-Site         | Latência, uptime      | Logs de túnel              | Zabbix, Email        |
| Load Balancer Local      | Conexões, status      | Logs de acesso             | Zabbix ou Prometheus |
| Aplicação Lançamentos    | Tempo de resposta     | Logs de acesso e erros     | Grafana Alerts       |
| AKS (Cloud)              | Pods, CPU, RAM, HPA   | Logs via Fluent Bit        | Azure Monitor Alerts |
| PostgreSQL (Azure)       | QPS, locks, conexões  | Logs de query              | Azure Metrics        |
| Azure Redis Cache        | Hits/misses, latência | Logs de operações de chave | Azure Monitor        |
| API Management           | Latência, erros 4xx   | Logs de requisição         | Azure Alerts         |

---

## 3. Monitoramento da Infraestrutura

### 🏢 On-Premises
- **Zabbix** (ou Prometheus Exporter) para VMs e rede local
- **Grafana** para visualização unificada

### ☁️ Azure
- **Azure Monitor** para métricas e alertas
- **Azure Log Analytics Workspace** para logs centralizados
- **Application Insights** para telemetria de aplicações (AKS, Functions)
- **Grafana (com Azure Data Source)** opcional para painéis customizados

---

## 4. Logs e Auditoria

- **Centralização de Logs**:
  - VMs locais: rsyslog → Zabbix ou ELK
  - Azure: Fluent Bit → **Log Analytics Workspace**

- **Retenção:**
  - 90 dias no workspace
  - 1 ano no **Azure Storage (Tier Archive)** para histórico

- **Auditoria de Eventos**:
  - AD (on-prem): logins, alterações de grupo
  - AKS: eventos de cluster, RBAC
  - PostgreSQL: slow queries e acessos privilegiados

---

## 5. Dashboards e Métricas

- **Grafana** ou **Azure Dashboards**:
  - Uso de CPU/RAM das VMs e pods
  - Latência de APIs e serviços
  - Tráfego de rede e falhas HTTP
  - Consumo de recursos no Redis e PostgreSQL

- **Painel FinOps**:
  - Consumo por tag (`env`, `project`)
  - Eficiência do HPA no AKS
  - Análise de custos (via Azure Cost Management)

---

## 6. Monitoramento de Rede

- **VPN Gateway (Azure)**:
  - Ping, jitter e uptime entre regiões/sites

- **Firewall UTM (On-Premises)**:
  - Tráfego suspeito e tentativas de acesso
  - Bloqueio automático via Fail2Ban

- **NetFlow + Traceroute**:
  - Diagnóstico de gargalos e roteamento

---

## 7. Alertas e Notificações

- Integrações:
  - **Email**
  - **Microsoft Teams**
  - **SMS**
  - **Opsgenie ou PagerDuty**

- Tipos de alerta:
  - Alta CPU/memória
  - Queda de pod no AKS
  - Erros 5xx em APIs
  - Falhas de conexão com banco ou VPN

---

## 8. Tracing e Diagnóstico

- **Application Insights + Azure Monitor Logs**
  - Rastreio de chamadas entre APIs (distributed tracing)
  - Performance de chamadas REST/HTTP no AKS
- **OpenTelemetry/Jaeger (opcional)**

---

## 9. Observabilidade e Segurança

- Dashboards com:
  - Tentativas de login mal-sucedidas
  - Logs de mudanças de RBAC e grupos
  - Correlação de falhas com eventos de segurança

---

## 10. Futuras Evoluções

- Adoção de **Azure Monitor Workbooks** personalizados
- Integração com **grafana.oncall**, **Azure Sentinel** (SIEM)
- Uso de **Azure Machine Learning + Monitor** para AIOps
- SLA dashboards por componente crítico

---