# 💰 Estratégia FinOps — Gestão de Custos em Infraestrutura Híbrida

## 🎯 Objetivo

A estratégia FinOps tem como foco **maximizar o valor da nuvem Azure**, promovendo eficiência financeira sem comprometer a performance ou a resiliência dos serviços. O projeto adota práticas contínuas de **monitoramento, otimização e previsibilidade de custos**, alinhadas aos pilares: **Colaboração, Visibilidade e Governança**.

---

## 🧭 Abordagem por Ambiente

### 🏢 On-Premises

- **Custo Fixo Controlado**
  - Aproveitamento da infraestrutura existente.
  - Virtualização e consolidação de VMs para otimizar uso.
  - Monitoramento de consumo com **Zabbix**.

- **Eficiência Operacional**
  - Desligamento programado de VMs redundantes fora do horário comercial.
  - Automatizações com Ansible para backup e desligamento programado.

---

### ☁️ Azure Cloud

- **Escalabilidade sob Demanda**
  - Autoescalabilidade horizontal no **AKS (HPA)**.
  - Uso de **Azure Functions** para cargas pontuais (event-driven).

- **Serviços Gerenciados**
  - Menor custo de manutenção e operação.
  - Adoção de **Azure PostgreSQL**, **Azure Redis Cache**, **APIM**, entre outros.

- **Previsibilidade e Planejamento**
  - Uso de **Azure Reservations** e **Savings Plans** para workloads contínuos.
  - Definição de **orçamentos e alertas via Azure Cost Management**.

- **Ambientes Inteligentes**
  - Desligamento automático de recursos de DEV/STG fora do expediente.
  - Agendamento via Azure Automation Runbooks.

---

## 📌 Práticas Adotadas

| Estratégia                     | Descrição                                                                 |
|-------------------------------|---------------------------------------------------------------------------|
| **Tagueamento de Recursos**    | Tags como `project`, `env`, `owner`, `costcenter` para rastreamento      |
| **Orçamentos e Alertas**       | Criados no Azure Cost Management + notificações via Teams ou Email       |
| **Relatórios e Dashboards**    | Painéis de consumo via **Azure Monitor**, **Grafana**, ou **Power BI**   |
| **Rightsizing**                | Ajustes baseados em métricas de CPU/memória via Azure Advisor            |
| **Reserva de Capacidade**      | Uso de planos de economia (Savings Plans) para PostgreSQL, Redis, etc.   |
| **Monitoramento via API**      | Integração com APIs do **Azure Billing** e **Azure Monitor**             |

---

## 🧰 Ferramentas Utilizadas

- **Azure Cost Management + Billing** — controle e projeção de gastos
- **Azure Advisor** — recomendações de otimização de custo/performance
- **Terraform + Infracost** — estimativas de custo durante o `plan`
- **Grafana + Azure Monitor** — dashboards em tempo real por ambiente
- **Azure Policy** — restrição de SKUs e controle de uso indevido

---

## 🏛️ Governança de Custos

- Reuniões mensais por equipe/produto para análise de gastos
- Validação obrigatória de tags e ambiente antes do provisionamento
- Definição de cotas (`quotas`) por assinatura ou grupo de recursos
- Auditoria contínua com Azure Policy e Cost Analysis

---

## 🔁 Ciclo Contínuo de FinOps

```mermaid
graph TD
    A[Visibilidade de Custos] --> B[Análise de Eficiência]
    B --> C[Otimização de Recursos]
    C --> D[Previsibilidade e Planejamento]
    D --> A
