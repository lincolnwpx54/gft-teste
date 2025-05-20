# Estratégia de Segurança — Infraestrutura Híbrida XPTO

## Objetivo

Estabelecer uma arquitetura segura e resiliente para os serviços da empresa XPTO, com foco em **proteção contra acessos indevidos**, **governança de identidade**, **segurança de rede**, **auditoria** e **conformidade**.

---

## 1. Autenticação e Gerenciamento de Identidades

### Active Directory (On-Premises)

- **Servidor Windows Server com AD Domain Services**
  - Domínio interno: `corp.xpto.local`
  - Gerenciamento de usuários, grupos, políticas (GPO)
  - DNS interno integrado

- **Usuários e Grupos**
  - Separação por função: `ti_admins`, `financeiro_lancamentos`, `auditoria_readonly`
  - Políticas de senha e bloqueio de conta ativas

- **Integração com Aplicações**
  - Autenticação dos usuários do sistema de lançamentos via **LDAP/LDAPS**
  - Controle de permissões por grupo AD (RBAC)

### Integração com Nuvem (Hybrid Identity)

- **Azure AD Connect**
  - Sincronização de usuários e grupos com Azure AD
  - Suporte a MFA, SSO, Conditional Access

- **LDAP via VPN**
  - Aplicações cloud acessam AD local com conexão segura por túnel

---

## 2. Controle de Acesso à Infraestrutura

| Componente     | Mecanismo de Acesso Seguro                     |
|----------------|------------------------------------------------|
| SSH nas VMs    | Chave pública/privada + controle por AD        |
| Aplicações     | Login com usuário AD (LDAP/LDAPS)              |
| Painel Web     | Autenticação integrada com SSO (Azure AD)      |
| Kubernetes     | RBAC com autenticação via OIDC ou IAM (cloud)  |
| Banco de Dados | Usuários com roles limitadas (read/write/super)|

- **Acesso com Bastion Host** para VMs na nuvem
- **Portas abertas apenas via firewall + regras de VPN**
- **Expiração e rotação de chaves SSH**

---

## 3. Segurança de Rede

- **VPN Site-to-Site**
  - IPsec com criptografia AES-256
  - Failover automático entre túneis
  - Tráfego interno criptografado entre on-prem e cloud

- **TLS/HTTPS**
  - Certificados válidos com renovação automática (Let's Encrypt/ACM)
  - TLS 1.2+ em todos os endpoints

- **Firewall (On-Prem e Cloud)**
  - Apenas portas essenciais abertas (ex: 443, 22 via jump box)
  - Regras com controle por IP origem e protocolo
  - IDS/IPS se disponível no gateway local (opcional)

---

## 4. Proteções no SO e Aplicações

- **SSH Hardened**
  - Desativado login por senha
  - Usuário padrão sem sudo
  - Porta customizada

- **Fail2Ban**
  - Proteção contra brute force (SSH, HTTP, etc.)

- **WAF (Web Application Firewall)**
  - Protege API Gateway e frontends contra injeções, XSS, etc.

- **Scan de Vulnerabilidades**
  - Ferramentas como Trivy (containers), ClamAV (on-prem), Snyk ou similar

---

## 5. Auditoria e Monitoramento

| Componente              | Ferramenta                  | Objetivo                       |
|-------------------------|-----------------------------|--------------------------------|
| AD e Login              | Logs do Windows + SIEM      | Auditoria de autenticações     |
| VMs on-prem             | Zabbix / Prometheus         | Recursos, alertas              |
| Kubernetes / Cloud      | Cloud Logging / Grafana     | Visibilidade e auditoria       |
| SSH e sudo              | Auditd / journald            | Registro de comandos           |
| Backup de logs          | Forward para central (ex: ELK)| Armazenamento e compliance    |

- **Alertas automatizados** por Slack, email e Opsgenie
- **Monitoramento contínuo de integridade** (tripwire, auditd)

---

## 6. Conformidade e Boas Práticas

- **MFA obrigatório** para administradores e usuários críticos
- **Revisão de acessos mensais**
- **Auditorias trimestrais** de logs e roles
- **Ambientes isolados**: dev, staging e prod
- **Política de retenção de logs:** 90 dias online, 1 ano arquivado

---

## 7. Futuras Melhorias

- Adoção de **Zero Trust Network Access (ZTNA)**
- Integração com **IAM centralizado** (Okta, Auth0, Keycloak)
- Monitoramento com **behavioral analysis (UEBA)**
- Aplicação de **Service Mesh com mTLS interno** (ex: Istio)

---

