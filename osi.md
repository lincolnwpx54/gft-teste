# Aplicação do Modelo OSI na Infraestrutura Híbrida XPTO

## Objetivo

O modelo OSI (Open Systems Interconnection) é uma referência essencial para projetar, monitorar e solucionar problemas em sistemas distribuídos. Nesta arquitetura híbrida (on-premises + cloud), o modelo OSI é aplicado para:

- Diagnóstico de falhas
- Otimização de comunicação
- Segurança em cada camada da rede
- Observabilidade e roteamento inteligente

---

## Camadas do Modelo OSI Aplicadas à Solução

| Camada | Nome                          | Aplicação na Arquitetura XPTO                                               |
|--------|-------------------------------|------------------------------------------------------------------------------|
| 7      | Aplicação                     | Serviços: API Gateway, Aplicação de Lançamentos, Serviço de Consolidação    |
| 6      | Apresentação                  | Criptografia TLS/SSL, encoding de dados, compressão                         |
| 5      | Sessão                        | Autenticação de sessão (JWT, LDAP), timeouts, controle de estado de APIs    |
| 4      | Transporte                    | Protocolos TCP/UDP, uso de portas seguras, inspeção de conexões             |
| 3      | Rede                          | Endereçamento IP, rotas VPN, firewall de camada 3 (NSG, Azure Firewall)     |
| 2      | Enlace de Dados               | Interfaces Ethernet, VLANs no on-prem, MAC filtering                        |
| 1      | Física                        | Conectividade física, cabeamento, roteadores e switches locais              |

---

## Exemplos de Uso Prático por Camada

### Camada 7 – Aplicação
- Monitoramento de **latência de APIs** e **códigos de resposta HTTP**
- Logs de erro em aplicações e APIs (ex: 500, 403, 504)
- Balanceamento de carga por URL ou path

### Camada 6 – Apresentação
- TLS 1.2+ em todos os fluxos HTTP e comunicação entre serviços
- Certificados gerenciados (Let's Encrypt, Azure Certificate Manager)
- Compressão de payloads JSON/XML

### Camada 5 – Sessão
- Sessões autenticadas com **JWT**
- Timeout de sessão no API Gateway
- Gerenciamento de sessão em aplicações web

### Camada 4 – Transporte
- Uso exclusivo de **TCP/443** e **TCP/22**
- Health checks via TCP nos load balancers
- Diagnóstico com ferramentas como `telnet`, `netstat`, `ss`

### Camada 3 – Rede
- VPN Site-to-Site com IPsec
- Segmentação de redes em subnets (App, DB, Infra)
- Análise de rotas com `traceroute`, `ping`, `mtr`

### Camada 2 – Enlace
- VLANs isoladas no ambiente on-premises
- Detecção de colisões ou loops via Spanning Tree Protocol (STP)
- MAC address tracking em switches gerenciáveis

### Camada 1 – Física
- Redundância de links WAN
- UPS/No-breaks no datacenter local
- Checagem de cabos e portas físicas em falhas de rede

---

## Diagnóstico Guiado com OSI

> Em caso de falha na aplicação, você pode aplicar uma abordagem de cima para baixo (camada 7 → 1):

1. **Aplicação indisponível?** Verifique logs de erro HTTP.
2. **Conexão recusada?** Verifique se a porta TCP está aberta.
3. **Problemas de rota?** Verifique a VPN e o tráfego ICMP.
4. **Sem resposta física?** Teste cabo, switch ou rede local.

---

## Benefícios do Modelo OSI na Arquitetura

- Acelera **resolução de incidentes**
- Garante **padronização de segurança**
- Facilita **documentação e observabilidade**
- Permite **identificação rápida de gargalos de rede**
- Suporta o design de soluções resilientes e escaláveis

---

## Conclusão

A infraestrutura híbrida XPTO aplica o modelo OSI de forma prática e integrada em suas camadas críticas. Essa abordagem promove um ambiente mais seguro, monitorável e confiável para os serviços essenciais da empresa.