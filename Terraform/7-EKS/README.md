# Módulo EKS - Elastic Kubernetes Service

Este módulo cria um cluster EKS completo com dynamic blocks para máxima flexibilidade e reutilização.

## 🚀 Características

- **Dynamic Blocks**: Configuração flexível via variáveis
- **Multi Node Groups**: Suporte a múltiplos grupos de nodes
- **Security Groups**: Configuração automática de SGs
- **IAM Roles**: Roles e políticas necessárias
- **Addons**: Instalação automática de addons essenciais
- **Fargate**: Suporte opcional ao Fargate
- **Logging**: Configuração de logs do cluster
- **Encryption**: Suporte a criptografia

## 📋 Pré-requisitos

1. **VPC configurada** (módulo 1-VPC)
2. **Security Groups** (módulo 1a-SegGroup)
3. **State remoto configurado** (módulo 0-TerraformState)

## 🛠️ Como usar

### 1. Configurar variáveis
```bash
cp terraform.tfvars.example terraform.tfvars
# Editar terraform.tfvars conforme necessário
```

### 2. Inicializar e aplicar
```bash
terraform init
terraform plan
terraform apply
```

### 3. Configurar kubectl
```bash
aws eks update-kubeconfig --region us-east-2 --name bia-eks-cluster
```

### 4. Verificar cluster
```bash
kubectl get nodes
kubectl get pods -A
```

## 🏗️ Arquitetura

```
┌─────────────────────────────────────────────────────────────┐
│                        EKS Cluster                         │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐    ┌─────────────────┐                │
│  │   Control Plane │    │   Node Groups   │                │
│  │                 │    │                 │                │
│  │ • API Server    │    │ • EC2 Instances │                │
│  │ • etcd          │    │ • Auto Scaling  │                │
│  │ • Scheduler     │    │ • Multiple AZs  │                │
│  │ • Controller    │    │ • Spot/OnDemand │                │
│  └─────────────────┘    └─────────────────┘                │
├─────────────────────────────────────────────────────────────┤
│                    Security Groups                         │
│  ┌─────────────────┐    ┌─────────────────┐                │
│  │  Cluster SG     │    │   Nodes SG     │                │
│  │                 │    │                 │                │
│  │ • API Access    │    │ • Node to Node  │                │
│  │ • HTTPS (443)   │    │ • SSH Access    │                │
│  └─────────────────┘    └─────────────────┘                │
├─────────────────────────────────────────────────────────────┤
│                      IAM Roles                             │
│  ┌─────────────────┐    ┌─────────────────┐                │
│  │  Cluster Role   │    │ Node Group Role │                │
│  │                 │    │                 │                │
│  │ • EKS Policies  │    │ • Worker Policies│                │
│  │ • VPC Controller│    │ • CNI Policy    │                │
│  └─────────────────┘    └─────────────────┘                │
└─────────────────────────────────────────────────────────────┘
```

## 🔧 Configurações Principais

### Node Groups
```hcl
node_groups = {
  general = {
    instance_types = ["t3.medium"]
    desired_size   = 2
    max_size       = 4
    min_size       = 1
    # ... outras configurações
  }
}
```

### Security Groups
```hcl
cluster_security_group_rules = {
  ingress = [
    {
      description = "HTTPS from nodes"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      security_groups = ["eks-nodes"]
    }
  ]
  # ... outras regras
}
```

### Addons
```hcl
cluster_addons = {
  "vpc-cni" = {
    version           = "v1.15.1-eksbuild.1"
    resolve_conflicts = "OVERWRITE"
  }
  # ... outros addons
}
```

## 📊 Outputs

- `cluster_endpoint`: Endpoint do cluster
- `cluster_certificate_authority_data`: Certificado CA
- `kubectl_config`: Comando para configurar kubectl
- `node_groups`: Informações dos node groups
- `security_group_ids`: IDs dos security groups

## 🔐 Security Groups

### Cluster Security Group
- **Ingress**: HTTPS (443) dos nodes
- **Egress**: Todo tráfego de saída

### Nodes Security Group
- **Ingress**: 
  - Comunicação entre nodes (self)
  - API do cluster (1025-65535)
  - SSH do security group dev
- **Egress**: Todo tráfego de saída

### ALB Security Group (opcional)
- **Ingress**: HTTP (80) e HTTPS (443) da internet
- **Egress**: Para os nodes EKS

## 🏷️ Tags

Todos os recursos são taggeados automaticamente com:
- `Environment`: dev/staging/prod
- `Project`: DevOps-001
- `ManagedBy`: Terraform
- `Owner`: Junior

## 🚨 Considerações de Segurança

1. **Endpoint Público**: Restringir `public_access_cidrs` em produção
2. **Node Groups**: Usar instâncias privadas
3. **IAM**: Princípio do menor privilégio
4. **Encryption**: Habilitar criptografia em produção
5. **Logging**: Habilitar todos os tipos de log

## 💰 Custos

### Componentes que geram custo:
- **Control Plane**: ~$73/mês por cluster
- **EC2 Instances**: Conforme node groups configurados
- **EBS Volumes**: Storage dos nodes
- **Data Transfer**: Tráfego entre AZs
- **CloudWatch Logs**: Se logging habilitado

### Otimização:
- Usar instâncias Spot para dev/test
- Configurar auto-scaling adequado
- Monitorar utilização de recursos

## 🔄 Próximos Passos

1. **Deploy de aplicações**: Usar kubectl ou Helm
2. **Ingress Controller**: AWS Load Balancer Controller
3. **Monitoring**: Prometheus + Grafana
4. **CI/CD**: Integração com pipelines
5. **Service Mesh**: Istio ou AWS App Mesh

## 📚 Comandos Úteis

```bash
# Verificar status do cluster
kubectl get nodes
kubectl get pods -A

# Verificar addons
kubectl get daemonset -n kube-system

# Logs do cluster (se habilitado)
aws logs describe-log-groups --log-group-name-prefix /aws/eks

# Escalar node group
aws eks update-nodegroup-config --cluster-name bia-eks-cluster --nodegroup-name general --scaling-config minSize=1,maxSize=5,desiredSize=3
```

## 🐛 Troubleshooting

### Problemas Comuns:

1. **Nodes não aparecem**:
   - Verificar IAM roles
   - Verificar security groups
   - Verificar subnets

2. **Pods não iniciam**:
   - Verificar recursos disponíveis
   - Verificar taints/tolerations
   - Verificar network policies

3. **Acesso negado**:
   - Verificar aws-auth ConfigMap
   - Verificar IAM permissions
   - Verificar kubectl config

### Logs importantes:
```bash
# Logs do kubelet nos nodes
kubectl logs -n kube-system -l k8s-app=aws-node

# Logs do CoreDNS
kubectl logs -n kube-system -l k8s-app=kube-dns
```
