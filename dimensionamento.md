# Dimensionamento de Recursos

## Visão Geral

O dimensionamento da infraestrutura leva em consideração os dois serviços principais — **Controle de Lançamentos** e **Consolidado Diário** — com foco em performance, escalabilidade e otimização de custos. O modelo proposto utiliza uma abordagem híbrida, aplicando **escala vertical para VMs locais** e **escala horizontal para workloads em nuvem**.

---

## Princípios Adotados

- **Alta disponibilidade (HA)**
- **Escalabilidade automática**
- **Provisionamento com base em carga**
- **Separação de responsabilidades por serviço**
- **Adoção de políticas FinOps**

---

## Serviço de Controle de Lançamentos (On-Premises)

| Recurso               | Valor Sugerido              |
|-----------------------|-----------------------------|
| CPU                  | 4 vCPUs                      |
| Memória              | 8 GB RAM                     |
| Armazenamento        | SSD 100 GB (NVMe)            |
| SO                   | Ubuntu Server LTS            |
| Tipo de Escala       | Vertical (upgrade sob demanda) |
| Tolerância a Falhas  | Ativa/Passiva (failover VM)  |

**Justificativa**:
- Executado localmente por conter dados sensíveis e estar vinculado a processos críticos internos.
- Escala vertical com redundância simples é suficiente para garantir continuidade.

---

## Serviço de Consolidado Diário (Cloud - Kubernetes)

| Recurso                        | Valor Sugerido                  |
|--------------------------------|---------------------------------|
| CPU por Pod                   | 1 vCPU                          |
| Memória por Pod               | 1.5 GB                          |
| Número inicial de réplicas    | 3                               |
| Autoescalabilidade            | Até 10 réplicas                 |
| HPA                           | Baseado em CPU (70%) e QPS      |
| Tipo de Workload              | Deployment Stateless            |
| Armazenamento                 | Não persistente (cache em Redis)|

**Justificativa**:
- Recebe picos de até **50 requisições por segundo**.
- Horizontal Pod Autoscaler mantém desempenho e disponibilidade.
- O uso de cache reduz o número de requisições ao banco.

---

## Banco de Dados (Cloud + Replica On-Prem)

| Recurso                        | Valor Sugerido              |
|--------------------------------|-----------------------------|
| Tipo                          | PostgreSQL (gerenciado)     |
| CPU                           | 2 vCPUs                     |
| Memória                       | 8 GB RAM                    |
| Armazenamento                 | SSD 100 GB com IOPS altos   |
| Réplica                       | Read-replica on-prem        |
| Backup                        | Diário + PITR (Point-in-time recovery) |
| Alta Disponibilidade          | Ativo/Ativo Multi-AZ        |

---

## Cache (Cloud Redis)

| Recurso         | Valor Sugerido         |
|-----------------|------------------------|
| Tipo            | Redis (gerenciado)     |
| Memória         | 2 GB                   |
| TTL médio       | 5 minutos              |
| Uso             | Armazenar dados consultados frequentemente |

---

## Componentes Auxiliares

- **API Gateway**
  - Escala automática
  - Suporte a autenticação JWT, throttling e logs

- **Load Balancer**
  - HTTP(S) externo com health checks
  - TLS com certificado gerenciado

- **Serverless Functions**
  - Execução de tarefas esporádicas: envio de notificações, limpeza de logs
  - Timeout máximo: 15s
  - Memória: 256 MB a 512 MB por execução

---

## Capacidade de Crescimento

- **Serviço de Consolidação** pode escalar horizontalmente de 3 para até 10 réplicas sem necessidade de intervenção manual.
- Banco de dados escalável verticalmente com upgrade automatizado de recursos conforme crescimento do volume de dados.

---

## Tolerância a Falhas

- **Serviço de Lançamentos** mantém VM standby local com IP reservado.
- **Serviço de Consolidação** é replicado entre zonas de disponibilidade.
- Banco de dados com failover automático e backups diários.

---

