# Arquitetura da Solução Híbrida — XPTO

## Visão Geral

A arquitetura proposta visa modernizar a infraestrutura legada da empresa XPTO, atualmente baseada em ambiente on-premises, migrando para um modelo **híbrido** que aproveita os benefícios de escalabilidade, segurança e resiliência proporcionados pela nuvem.

A solução foi desenhada para suportar os seguintes pilares:

- Alta disponibilidade e performance
- Integração segura entre on-premises e cloud
- Escalabilidade horizontal em períodos de pico
- Redução de custos com práticas FinOps
- Resiliência contra falhas e recuperação rápida

---

## Diagrama de Topologia

![Diagrama da Arquitetura](diagrama/topologia.png)

> Obs.: O diagrama encontra-se no diretório `diagrama/`.

---

## Componentes Principais

### 🔹 On-Premises

- **Serviço de Controle de Lançamentos**
  - Mantido localmente por requisitos de compliance e dados sensíveis.
  - Executado em uma VM com balanceador local (HAProxy/Nginx).
  - Comunicação segura com os componentes em nuvem via VPN e TLS.

### Cloud (AWS/GCP/Azure)

- **Serviço de Consolidado Diário**
  - Migrado para ambiente cloud com autoescalabilidade via Kubernetes.
  - Exposto através de Load Balancer gerenciado (ex: ALB/GCLB).
  - Executa em contêineres (EKS/GKE/AKS).

- **Banco de Dados**
  - **CloudSQL / RDS** com réplicas para alta disponibilidade.
  - Backups automatizados e encriptados.

- **Cache**
  - Redis (gerenciado) para reduzir latência nos acessos frequentes.

- **API Gateway**
  - Segurança e roteamento de chamadas externas com autenticação JWT e rate limiting.

- **Serverless**
  - Funções pontuais como geração de relatórios e envio de notificações.

---

## Segurança e Acesso

- **VPN Site-to-Site**
  - Interligação segura entre o datacenter local e a nuvem.
  
- **Protocolos Utilizados**
  - SSH para administração de VMs (com bastion host).
  - HTTPS para comunicação entre serviços.
  - TLS mútua em conexões críticas.

- **IAM e RBAC**
  - Controle de permissões granulares nos recursos cloud e Kubernetes.

---

## Integração On-Premises + Cloud

| Recurso             | Local               | Nuvem                    | Comunicação                     |
|---------------------|---------------------|---------------------------|---------------------------------|
| Serviço de Lançamentos | VM local             | —                         | Exposto via Load Balancer local |
| Serviço de Consolidação | —                 | Kubernetes (nuvem)        | VPN + API Gateway               |
| Banco de Dados      | Replica local (read) | Principal (cloud)         | Sincronização e failover        |

---

## Justificativas Arquiteturais

- **Ambiente Híbrido** permite aproveitamento de infraestrutura existente com elasticidade da nuvem.
- **Kubernetes** oferece escalabilidade automática e resiliência.
- **Serverless** reduz custos em tarefas não contínuas.
- **VPN Site-to-Site** mantém comunicação segura e privada.
- **API Gateway** centraliza segurança e controle de tráfego.
- **Redis Cache** melhora a performance de leitura no serviço de consolidação.

---

## Considerações Futuras

- Migração total para cloud em médio prazo.
- Adoção de **service mesh** para observabilidade e segurança intra-serviços (ex: Istio).
- Implementação de **CI/CD completo** com GitOps.
- Substituição das VMs locais por contêineres em ambiente edge/híbrido.

---

