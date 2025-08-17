# Correções Aplicadas nos Dynamic Blocks dos Security Groups

## Problemas Identificados e Soluções

### 1. **Problema: Security Groups referenciando strings em vez de IDs**
**Erro:** No `bia-ec2` e `bia-db`, as security_groups estavam sendo passadas como strings ("bia-alb") em vez dos IDs reais.

**Solução:** Implementado mapeamento usando `locals`:
```hcl
# Em Locals-Fixed.tf
locals {
  source_sgs = {
    "bia-web"       = aws_security_group.bia-web.id
    "bia-ec2"       = aws_security_group.bia-ec2.id
    "bia-dev-mssql" = aws_security_group.bia-dev-mssql.id
    "bia-build"     = aws_security_group.bia-build.id
    "bia-dev"       = aws_security_group.bia-dev.id
    "bia-alb"       = aws_security_group.bia-alb.id
  }
}

# No dynamic block
security_groups = [
  for sg_name in ingress.value["security_groups"] : local.source_sgs[sg_name]
]
```

### 2. **Problema: Inconsistência na estrutura das variáveis**
**Erro:** Algumas variáveis usavam a chave como porta (`default_ingress`) e outras usavam `from_port/to_port`.

**Solução:** Padronizado todas as variáveis para usar `from_port/to_port` exceto `default_ingress` que mantém o padrão original.

### 3. **Problema: Protocolo incorreto na variável bia-build**
**Erro:** `protocol = -1` (sem aspas)

**Solução:** `protocol = "-1"` (com aspas)

### 4. **Problema: Porta MSSQL incorreta**
**Erro:** `from_port = 1443` (deveria ser 1433)

**Solução:** `from_port = 1433`

### 5. **Problema: Dependências não explícitas**
**Erro:** Security groups que referenciam outros não tinham `depends_on`.

**Solução:** Adicionado `depends_on` explícito:
```hcl
depends_on = [
  aws_security_group.bia-alb,
  aws_security_group.bia-dev
]
```

## Como Usar os Arquivos Corrigidos

### Opção 1: Substituir arquivos existentes
```bash
# Backup dos arquivos originais
cp SecGrupDynamicBlock.tf SecGrupDynamicBlock.tf.backup
cp Variaveis.tf Variaveis.tf.backup
cp Locals.tf Locals.tf.backup

# Substituir pelos corrigidos
cp SecGrupDynamicBlock-Fixed.tf SecGrupDynamicBlock.tf
cp Variaveis-Fixed.tf Variaveis.tf
cp Locals-Fixed.tf Locals.tf
```

### Opção 2: Testar com novos arquivos
```bash
# Renomear arquivos originais
mv SecGrupDynamicBlock.tf SecGrupDynamicBlock.tf.old
mv Variaveis.tf Variaveis.tf.old
mv Locals.tf Locals.tf.old

# Renomear arquivos corrigidos
mv SecGrupDynamicBlock-Fixed.tf SecGrupDynamicBlock.tf
mv Variaveis-Fixed.tf Variaveis.tf
mv Locals-Fixed.tf Locals.tf
```

## Validação

Após aplicar as correções, execute:

```bash
# Validar sintaxe
terraform validate

# Verificar plano
terraform plan

# Aplicar se tudo estiver correto
terraform apply
```

## Estrutura Final dos Dynamic Blocks

### Para Security Groups simples (apenas CIDR):
```hcl
dynamic "ingress" {
  for_each = var.bia-dev
  content {
    description = ingress.value["description"]
    from_port   = ingress.value["from_port"]
    to_port     = ingress.value["to_port"]
    protocol    = ingress.value["protocol"]
    cidr_blocks = ingress.value["cidr_blocks"]
  }
}
```

### Para Security Groups que referenciam outros SGs:
```hcl
dynamic "ingress" {
  for_each = var.bia-ec2
  content {
    description = ingress.value["description"]
    from_port   = ingress.value["from_port"]
    to_port     = ingress.value["to_port"]
    protocol    = ingress.value["protocol"]
    security_groups = [
      for sg_name in ingress.value["security_groups"] : local.source_sgs[sg_name]
    ]
  }
}
```

### Para Security Groups com CIDR e SGs opcionais:
```hcl
dynamic "ingress" {
  for_each = var.windows-sg
  content {
    description = ingress.value["description"]
    from_port   = ingress.value["from_port"]
    to_port     = ingress.value["to_port"]
    protocol    = ingress.value["protocol"]
    cidr_blocks = lookup(ingress.value, "cidr_blocks", [])
    security_groups = length(lookup(ingress.value, "security_groups", [])) > 0 ? [
      for sg_name in ingress.value.security_groups : local.source_sgs[sg_name]
    ] : []
  }
}
```

## Benefícios das Correções

1. **Eliminação de erros de referência circular**
2. **Código mais limpo e consistente**
3. **Melhor reutilização através de variáveis padronizadas**
4. **Dependências explícitas garantem ordem correta de criação**
5. **Suporte a configurações mistas (CIDR + Security Groups)**
