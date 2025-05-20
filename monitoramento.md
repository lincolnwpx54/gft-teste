# Estratégia de Monitoramento e Observabilidade

## Objetivo

Garantir **alta visibilidade**, **detecção proativa de falhas** e **resposta rápida a incidentes**, monitorando todos os componentes da infraestrutura híbrida da XPTO, incluindo servidores, containers, rede, banco de dados, aplicações e usuários.

---

## 1. Visão Geral

A estratégia de monitoramento cobre três pilares da observabilidade:

- **Métricas (Metrics)**
- **Logs**
- **Traces**

Cada componente da infraestrutura é integrado a pelo menos uma dessas camadas de observação.

---

## 2. Componentes Monitorados

| Componente               | Métricas           | Logs               | Alertas        |
|--------------------------|--------------------|---------------------|----------------|
| VMs On-Prem              | CPU, RAM, Disco     | Syslog, SSH, sudo   | Zabbix         |
| VPN Site-to-Site         | Latência, uptime    | Logs de túnel       | Zabbix, Email  |
| Load Balancer Local      | Conexões, status    | Logs de acesso      | Prometheus     |
| Aplicação Lançamentos    | Tempo de resposta   | Acesso, erros       | Grafana Alerts |
| Kubernetes (Cloud)       | Pods, HPA, CPU, RAM | Logs via Fluentd    | Cloud Alerts   |
| Banco de Dados (Cloud)   | QPS, locks, conexões| Logs de query       | RDS Metrics    |
| Redis                    | Hits/misses         | Operações de chave  | Cloud Monitor  |
| API Gateway              | Latência, erros 4xx | Logs de requisição  | Cloud Alerts   |

---

## 3. Monitoramento de Infraestrutura

### On-Premises
- **Zabbix** ou **Prometheus Node Exporter** para VMs, rede e sistema
- **Grafana** para visualização consolidada
- **Alertmanager** para disparo de alertas

### Cloud
- **Cloud Monitoring** (GCP/AWS/Azure)
- **Kubernetes Metrics Server + Prometheus** (via Helm)
- **Grafana Cloud ou self-hosted**

---

## 4. Logs e Auditoria

- **Centralização de logs**:
  - VMs on-prem: rsyslog → Zabbix ou ELK stack
  - Cloud/K8s: Fluent Bit/Fluentd → Stackdriver, CloudWatch ou ELK
- **Retenção:**
  - 90 dias em tempo real
  - 1 ano em armazenamento de baixo custo (S3, GCS, Azure Blob)

- **Auditoria de eventos**:
  - AD (on-prem): logins, alterações de grupo
  - Kubernetes: eventos do cluster e RBAC
  - Banco de dados: logs de slow queries e acessos privilegiados

---

## 5. Dashboards e Métricas

- **Grafana**: dashboards unificados com visão de:
  - Tempo de resposta das APIs
  - Uso de CPU/memória das VMs e pods
  - Requisições por segundo nos serviços
  - Falhas por código HTTP (404, 500, etc.)
  - Latência na VPN e conectividade on-prem ↔ cloud

- **Painel especial para FinOps**:
  - Custos por serviço
  - Consumo por tag (ex: `env=prod`)
  - Eficiência do HPA/Auto Scaling

---

## 6. Monitoramento da Rede

- **VPN Gateway**:
  - Ping, jitter e latência entre sites
  - Logs de reconexão ou falhas

- **Firewall/IDS/IPS (on-premises)**:
  - Logs de tráfego suspeito
  - Bloqueios automáticos com Fail2Ban

- **Traceroute/NetFlow**:
  - Verificação de roteamento e gargalos

---

## 7. Alertas e Notificações

- Integração com:
  - **Email**
  - **Slack**
  - **Microsoft Teams**
  - **Opsgenie** (para incidentes graves)

- **Tipos de Alertas**:
  - Alta CPU ou memória
  - Falha de VPN ou API
  - Tempo de resposta elevado
  - Queda de pod no Kubernetes
  - Perda de conectividade com banco

---

## 8. Tracing e Diagnóstico

- **OpenTelemetry** ou **Jaeger** (opcional)
  - Rastreio de chamadas entre microserviços
  - Análise de gargalos em requisições complexas

---

## 9. Observabilidade e Segurança

- Correlacionamento entre logs de segurança e acesso
- Dashboards com tentativas de login mal sucedidas
- Alertas para alterações em usuários, permissões e políticas

---

## 10. Futuras Evoluções

- Adoção de **AI Ops** para detecção preditiva de falhas
- Uso de **tempo de atividade por usuário** (end-to-end UX)
- Integração com **grafana.oncall**, **LOKI**, ou **Tempo**
- Aplicação de **SLA dashboard** com indicadores de uptime por serviço

---

