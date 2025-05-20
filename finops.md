# Estratégia FinOps — Gestão de Custos em Infraestrutura Híbrida

## 🎯 Objetivo

A estratégia FinOps tem como foco **maximizar o valor da nuvem**, promovendo a eficiência financeira sem comprometer a performance ou a resiliência dos serviços. Neste projeto, são aplicadas práticas contínuas de **monitoramento, otimização e previsibilidade de custos**, alinhadas aos pilares do FinOps: **Colaboração, Visibilidade e Governança**.

---

## 🧩 Abordagem por Ambiente

### 🏢 On-Premises

- **Custo Fixo Controlado**
  - Aproveitamento da infraestrutura existente.
  - Virtualização para melhor uso de recursos.
  - Uso de ferramentas de monitoramento local (ex: Zabbix, Prometheus) para controle de consumo.

- **Desligamento programado de VMs redundantes** fora do horário de pico.

---

### ☁️ Cloud

- **Escalabilidade sob demanda**
  - Habilitação de **autoescalabilidade horizontal** no Kubernetes (ex: HPA).
  - **Serverless functions** para workloads não contínuos (ex: geração de relatórios).

- **Uso de Serviços Gerenciados**
  - Redução de custos operacionais (manutenção, patches, backup).
  - RDS/CloudSQL, Redis, API Gateway gerenciados.

- **Previsibilidade**
  - Reservas de instância ou planos de compromisso para serviços de uso contínuo.
  - Alertas de gastos e orçamentos definidos por serviço.

- **Desligamento Automático**
  - Políticas para desligar ambientes de teste/dev fora do expediente.

---

## 💰 Práticas Adotadas

| Estratégia                     | Descrição                                                                 |
|-------------------------------|---------------------------------------------------------------------------|
| **Tagueamento de Recursos**    | Identificação por ambiente, time, projeto (ex: `env=prod`, `team=fin`)   |
| **Orçamentos e Alertas**       | Definição de limites de gastos mensais com alertas por e-mail/Slack       |
| **Relatórios de Uso**          | Dashboards com uso por serviço, por equipe e por período                  |
| **Rightsizing**                | Ajuste fino de máquinas e contêineres com base em métricas reais          |
| **Reserva de Capacidade**      | Uso de instâncias reservadas ou savings plans para workloads estáticos    |
| **Monitoramento por API**      | Integração com ferramentas como CloudWatch, Azure Monitor ou GCP Billing  |

---

## 🛠️ Ferramentas

- **Grafana + Prometheus** — para dashboards de consumo de recursos e métricas de uso.
- **Cloud Billing** (AWS, GCP ou Azure) — para relatórios detalhados de custos por serviço.
- **Terraform com Cost Estimation Plugins** — estimativa de custo por recurso na etapa de planejamento.
- **Infracost** — cálculo automático de custos direto na PR do Git (para Terraform).

---

## 🚦 Governança de Custos

- Reuniões mensais de revisão de gastos por time/produto.
- Checklists de validação antes da criação de novos recursos.
- Adoção de **ambientes segregados** (dev, staging, prod) com cotas e limites.

---

## 🔄 Ciclo Contínuo de FinOps

```mermaid
graph TD
    A[Visibilidade de Custos] --> B[Análise de Eficiência]
    B --> C[Otimização de Recursos]
    C --> D[Previsibilidade e Planejamento]
    D --> A
