<!-- BEGIN_TF_DOCS -->
# Terraform - Infraestrutura AWS para Desafios da Formação AWS 5.0

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Repositório contendo a infraestrutura básica em Terraform para concretizar os desafios da **Formação AWS 5.0** e **Mentoria de Desafios Labs 2.0**.

## 📌 Objetivo

Fornecer a infraestrutura fundamental necessária para:
- Realizar os desafios da Formação AWS 5.0
- Suportar os labs da Mentoria de Desafios 2.0
- Servir como base para estudos de AWS com Terraform

## 🛠️ Estrutura do Repositório
.
├── 1a-VPC/ # Módulo de rede básica
├── 1b-EC2/ # Configurações de instâncias EC2
├── 2a-RDS/ # Banco de dados relacional
├── 3a-Lambda/ # Funções serverless
├── 4a-S3/ # Armazenamento de objetos
└── modules/ # Módulos reutilizáveis

✅ Pontos Fortes
Estrutura bem organizada com separação clara de responsabilidades

CI/CD implementado com GitHub Actions e pre-commit hooks

Remote State configurado com S3

Módulos reutilizáveis do Terraform Registry

Documentação automatizada com terraform-docs


## 📋 Pré-requisitos

- Conta AWS com permissões adequadas
- Terraform instalado (versão ≥ 1.0.0)
- AWS CLI configurado
- Git instalado

## 🚀 Como Usar

1. Clone o repositório:
   ```bash
   git clone https://github.com/crfjunior65/Terraform-Bia-CI-CD.git

⚠️ Importante

    Nunca comite credenciais AWS

    Sempre destrua recursos após uso para evitar custos:


🤝 Contribuição

Contribuições são bem-vindas! Siga os passos:

    Fork este repositório

    Crie uma branch (git checkout -b feature/nova-feature)

    Commit suas mudanças (git commit -am 'Adiciona nova feature')

    Push para a branch (git push origin feature/nova-feature)

    Abra um Pull Request

📜 Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para detalhes.
🙏 Agradecimentos

    Equipe da Formação AWS 5.0

    Mentores dos Labs 2.0

    Comunidade DevOps

Pre-Commit OK

❯ git commit -m "Go: Execucao Terraform"
trim trailing whitespace.................................................Passed
fix end of files.........................................................Passed
Terraform fmt............................................................Passed
Terraform validate.......................................................Passed
Terraform docs...........................................................Passed
[main bc40976] Go: Execucao Terraform
 12 files changed, 35 insertions(+), 65 deletions(-)

<!-- END_TF_DOCS -->
