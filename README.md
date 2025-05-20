# Desafio Técnico — Arquiteto de Soluções em Infraestrutura

## Sobre o Projeto

Este projeto foi desenvolvido como solução para o desafio técnico proposto pela empresa XPTO, com foco na migração de infraestrutura de um ambiente on-premises para um modelo híbrido (cloud + local). A solução foi desenhada para garantir escalabilidade, segurança, resiliência e controle de custos através de boas práticas de arquitetura e automação.

## Componentes da Solução

- **Ambiente Híbrido (On-prem + Cloud)**
- **Alta Disponibilidade e Escalabilidade**
- **Segurança de Acesso e Tráfego**
- **Automação com Terraform e Ansible**
- **Plano de Recuperação de Desastres (DR)**
- **Monitoramento e Observabilidade**
- **Estratégia FinOps**

## Documentação

| Documento         | Descrição                                                                 |
|------------------|---------------------------------------------------------------------------|
| `arquitetura.md`  | Diagrama de topologia e explicações sobre a arquitetura híbrida proposta |
| `dimensionamento.md` | Detalhes de CPU, memória, escala horizontal e vertical dos serviços    |
| `finops.md`       | Estratégia de controle e otimização de custos                             |
| `automacao.md`    | Aplicação de Infraestrutura como Código (IaC)                             |
| `dr.md`           | Plano de Disaster Recovery com RTO e RPO                                  |
| `monitoramento.md`| Proposta de observabilidade e monitoramento da rede                      |
| `seguranca.md`      | Estratégia de segurança, autenticação (AD), controle de acesso e hardening|
| `osi.md`          | Aplicação do modelo OSI na solução para performance e segurança           |

## Diagrama de Topologia

A topologia da solução encontra-se no diretório `diagrama/topologia.png`.

## Como Utilizar

O repositório contém exemplos de código e instruções para automatizar o provisionamento da infraestrutura utilizando Terraform e Ansible (ver `automacao.md`).

## Autor

Desenvolvido por Lincoln Venâncio, para o desafio técnico de Arquiteto de Soluções em Infraestrutura.

---


### Os trechos de código fornecidos têm finalidade ilustrativa, demonstrando a estrutura e organização da Infraestrutura como Código (IaC) utilizada para exemplificar a arquitetura proposta.
